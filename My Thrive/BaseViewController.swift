//
//  BaseViewController.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    enum PageState {
        case LOADING
        case DONE
        case ERROR
    }
    
    
    var indicatorView : UIActivityIndicatorView!
    override func viewDidLoad() {
        self.initIndicatorView()
    }
    
    func initIndicatorView()
    {
        indicatorView = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 100, height: 100)))
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.color = UIColor.darkGray
        indicatorView.center = self.view.center
        self.view.addSubview(indicatorView)
        
        //indicatorView.isHidden = true
    }
    
    func viewsForStateChange() -> [UIView]!
    {
        return [];
    }
    
    
    func setPageState(pageState : PageState)
    {
        
        switch pageState {
        case .LOADING:
            
            for view : UIView in viewsForStateChange(){
                view.isHidden = true
            }
            indicatorView.startAnimating()
            break
            
        case .DONE:
            for view : UIView in viewsForStateChange(){
                view.isHidden = false
            }
            indicatorView.stopAnimating()
            break
            
        default:
            break
        }
    }
    
}
