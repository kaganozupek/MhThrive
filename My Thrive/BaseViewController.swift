//
//  BaseViewController.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {


    enum PageState {
        case LOADING
        case DONE
        case ERROR
    }

    var sideBarContainer: UIView!
    var indicatorView: UIActivityIndicatorView!
    var sideBarWidth: CGFloat!
    var sideBarCloseView: UIView!
    var sideBarController : UIViewController!
    var errorButton : UILabel!
    var rootView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Utils.sharedInstance.isOnIpad() && getViewRoot() != nil
        {
            rootView = getViewRoot()
        
        }else{
            rootView = self.view
        }
      
        self.initIndicatorView()
        self.initTapToRetryView()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            _ = self.getCenterOfScreen()
        }
    }
    
    

    
    
    func getCenterOfScreen() -> CGPoint
    {
        if !Utils.sharedInstance.isOnIpad(){
            let screenRect : CGRect = UIScreen.main.bounds
            print(CGPoint(x: screenRect.width/2, y: screenRect.height/2)
)
            return CGPoint(x: screenRect.width/2, y: screenRect.height/2)
        }else
        {   print(CGPoint(x: rootView.frame.size.width/2, y: rootView.frame.size.height/2))
            return CGPoint(x: rootView.frame.size.width/2, y: rootView.frame.size.height/2)
        }
    }
    
    func initIndicatorView()
    {
        indicatorView = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 100, height: 100)))
        
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.color = UIColor.darkGray
        indicatorView.center = getCenterOfScreen()
        rootView.addSubview(indicatorView)

        //indicatorView.isHidden = true
    }
    
    func initTapToRetryView()
    {
        errorButton = UILabel(frame: CGRect(origin: CGPoint(), size: CGSize(width: rootView.frame.width - 20, height: 100)))
        errorButton.textColor = UIColor.black
        errorButton.center = getCenterOfScreen()
        
        rootView.addSubview(errorButton)
        errorButton.isHidden = true
        errorButton.numberOfLines = 0
        errorButton.textAlignment = .center
        errorButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onRetryTapped)))
        errorButton.isUserInteractionEnabled = true
    }
    
    
    func onRetryTapped()
    {
    
    }
    
    func getViewRoot() -> UIView!
    {
        return nil
    }


    func viewsForStateChange() -> [UIView]!
    {
        return []
    }


    func setPageState(pageState : PageState)
    {
        setPageState(pageState : pageState,error : nil)
    }
    
    func setPageState(pageState: PageState,error : String!)
    {

        switch pageState {
        case .LOADING:

            for view: UIView in viewsForStateChange() {
                view.isHidden = true
            }
            indicatorView.startAnimating()
            errorButton.isHidden = true
            break

        case .DONE:
            for view: UIView in viewsForStateChange() {
                view.isHidden = false
            }
            indicatorView.stopAnimating()
             errorButton.isHidden = true
            break
        case .ERROR:
            for view: UIView in viewsForStateChange() {
                view.isHidden = true
            }
            indicatorView.stopAnimating()
            errorButton.isHidden = false
            if(error != nil){
                errorButton.text = error
            }
            break
        
        }
    }

    func setupSideBar(container : UIView!)
    {
        if(!Utils.sharedInstance.isOnIpad())
        {
            let screenSize: CGRect = UIScreen.main.bounds
            sideBarWidth = screenSize.size.width * Constants.dimensionRatioSideBar
            let sideBarRect: CGRect = CGRect(x: -sideBarWidth, y: 0, width: sideBarWidth, height: screenSize.size.height)
            sideBarContainer = UIView(frame: sideBarRect)
            
            sideBarCloseView = UIView(frame: screenSize)
            sideBarCloseView.backgroundColor = UIColor.black
            sideBarCloseView.alpha = 0.0

            self.view.addSubview(sideBarCloseView)
            self.view.addSubview(sideBarContainer)
            self.setupSideBarGestureRecognizers()
        }else{
            if container != nil{
                let sideBarRect: CGRect = CGRect(x: 0, y: 0, width: container.frame.size.width, height: container.frame.size.height)
                sideBarContainer = UIView(frame: sideBarRect)
                container.addSubview(sideBarContainer)
            }
            
        }
        sideBarController = SideBarController(nibName: "SideBarController", bundle: nil);
        self.addChildViewController(sideBarController)
        sideBarController.view.frame = CGRect(x: 0, y: 0, width: sideBarContainer.frame.size.width, height: sideBarContainer.frame.size.height)
        sideBarContainer.addSubview(sideBarController.view)
        sideBarContainer.backgroundColor = UIColor.blue
        sideBarController.didMove(toParentViewController: self)
    }


    private func setupSideBarGestureRecognizers()
    {
        let screenLeftRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(BaseViewController.onLeftEdgeGestureRecognized))
        screenLeftRecognizer.edges = .left
        screenLeftRecognizer.delegate = self
        self.view.addGestureRecognizer(screenLeftRecognizer)

        let sideBarGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BaseViewController.onSideBarPanGestureRecognizer(gesture:)))
        sideBarGestureRecognizer.delegate = self
        self.sideBarContainer.addGestureRecognizer(sideBarGestureRecognizer)

        let closeViewTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.onCloseViewTapped))
        closeViewTapRecognizer.delegate = self
        self.sideBarCloseView.addGestureRecognizer(closeViewTapRecognizer)

    }

    var lastValue: CGFloat = 0


    func onCloseViewTapped()
    {
        hideSideBar(duration: Constants.valueDefaultSideBarAnimationDuration)
    }


    func onLeftEdgeGestureRecognized(gesture: UIScreenEdgePanGestureRecognizer)
    {
        let translation: CGPoint = gesture.translation(in: gesture.view)

        let difference = lastValue - translation.x
        lastValue = translation.x
        let velocity: CGPoint = gesture.velocity(in: self.view)
        if(gesture.state == .ended)
        {
            if(velocity.x > 0)
            {
                showSideBar(duration: self.calculateAnimationDudationForOpenAnimation(gesture: gesture))
            } else
            {
                hideSideBar(duration: self.calculateAnimationDudationForOpenAnimation(gesture: gesture))
            }
            lastValue = 0
        }
            else
        {
            self.moveSideBar(x: difference)
        }

    }

    func onSideBarPanGestureRecognizer(gesture: UIPanGestureRecognizer)
    {
        let translation: CGPoint = gesture.translation(in: gesture.view)
        let difference = lastValue - translation.x
        lastValue = translation.x
        let velocity: CGPoint = gesture.velocity(in: self.view)
        if(gesture.state == .ended)
        {

            if(velocity.x < 0)
            {
                hideSideBar(duration: self.calculateAnimationDudationForCloseAnimation(gesture: gesture))
            } else
            {
                showSideBar(duration: self.calculateAnimationDudationForCloseAnimation(gesture: gesture))

            }
            lastValue = 0
        } else
        {
            moveSideBar(x: difference)

        }

    }


    private func moveSideBar(x: CGFloat)
    {
        var currentRect = sideBarContainer.frame
        let totalPosition = currentRect.origin.x - x
        if(totalPosition <= 0 && totalPosition >= -1 * sideBarWidth)
        {
            currentRect.origin.x = totalPosition
            sideBarContainer.frame = currentRect
        }
        sideBarCloseView.alpha = calculateAlphaForCloseView(rect: sideBarContainer.frame)

    }

    private func calculateAlphaForCloseView(rect: CGRect) -> CGFloat {

        let distanceRatio = 1 - (CGFloat(abs(rect.origin.x)) / sideBarWidth)
        print(distanceRatio)
        return Constants.valueSideBarCloseViewDefaultAlpha * distanceRatio

    }

    private func calculateAnimationDudationForOpenAnimation(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat
    {
        let velocity: CGPoint = gesture.velocity(in: self.view)
        let totalWay = abs(sideBarContainer.frame.origin.x - 0)
        let duration = totalWay / velocity.x
        if(duration <= Constants.valueDefaultSideBarAnimationDuration) {
            return totalWay / velocity.x
        }
            else {
                return Constants.valueDefaultSideBarAnimationDuration
        }



    }


    private func calculateAnimationDudationForCloseAnimation(gesture: UIPanGestureRecognizer) -> CGFloat
    {
        let velocity: CGPoint = gesture.velocity(in: self.view)
        let totalWay = abs(abs(sideBarContainer.frame.origin.x) - sideBarWidth)
        let duration = totalWay / velocity.x
        if(duration <= Constants.valueDefaultSideBarAnimationDuration) {
            return totalWay / velocity.x
        }
            else {
                return Constants.valueDefaultSideBarAnimationDuration
        }



    }

    func showSideBar(duration: CGFloat)
    {
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveEaseOut], animations: {
            self.sideBarContainer.frame.origin.x = 0
            self.sideBarCloseView.alpha = Constants.valueSideBarCloseViewDefaultAlpha
        }) { (completed) in


        }
    }

    private func hideSideBar(duration: CGFloat)
    {
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveEaseOut], animations: {
            self.sideBarContainer.frame.origin.x = self.sideBarWidth * -1
            self.sideBarCloseView.alpha = 0.0
        }) { (completed) in


        }
    }



}

















