//
//  BookNowController.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/26/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import DatePickerDialog
class BookNowController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var stackViewForm: UIStackView!
    @IBOutlet weak var btnBookNow: UIButton!
    
    var formItemEventName : BookFormItem!
    var formItemCreator : BookFormItem!
    var formItemStartDate : BookFormItem!
    var formItemStartTime : BookFormItem!
    var formItemEndTime : BookFormItem!
    
    
    
    var startDate : Date!
    var startTime : Date!
    var endTime : Date!
    
    var liveValidation : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear;
        self.modalPresentationStyle = .currentContext;
        self.modalPresentationStyle = .formSheet;
        self.initViews()
        initForm()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initViews()
    {
        viewPopUp.layer.cornerRadius = Constants.dimensionBookNowViewCornerRadius
        viewPopUp.clipsToBounds = true
        viewPopUp.layer.borderColor = UIColor.darkGray.cgColor
        viewPopUp.layer.borderWidth = 1
        var closeImage = UIImage(named: "ic_close")
        closeImage = closeImage?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(closeImage, for: .normal)
        btnClose.tintColor = UIColor.white
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6) {
            self.viewBackground.alpha = 0.7
        }
        
    }
    
    func initForm()
    {
        
        formItemEventName = UINib(nibName: "BookFormItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BookFormItem
        formItemCreator = UINib(nibName: "BookFormItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BookFormItem
        formItemEndTime = UINib(nibName: "BookFormItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BookFormItem
        formItemStartDate = UINib(nibName: "BookFormItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BookFormItem
        formItemStartTime = UINib(nibName: "BookFormItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BookFormItem
        
        formItemEventName.setup(hint: "Event Name", enabled: true, warning: "Event name should be less then 20 more than 5 charachters")
        formItemCreator.setup(hint: "Event Owner", enabled: true, warning: "Event owner should be less then 20 more than 5 charachters")
        formItemStartDate.setup(hint: "Date", enabled: false, warning: "Date cannot not be empty")
        formItemStartTime.setup(hint: "Start Time", enabled: false, warning: "Start time cannot not be empty")
        formItemEndTime.setup(hint: "End Time", enabled: false, warning: "End time cannot not be empty")
        
        
        addItemToStackView(view: formItemEventName, height: 62)
        addItemToStackView(view: formItemCreator, height: 62)
        addItemToStackView(view: formItemStartDate, height: 62)
        addItemToStackView(view: formItemStartTime, height: 62)
        addItemToStackView(view: formItemEndTime, height: 62)
        
        let tapRecognizeStartDate : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onFormItemTapped(gesture:)))
        let tapRecognizeStartTime : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onFormItemTapped(gesture:)))
        let tapRecognizeEndTime : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onFormItemTapped(gesture:)))
        
       
        formItemStartDate.addGestureRecognizer(tapRecognizeStartDate)
        formItemStartTime.addGestureRecognizer(tapRecognizeStartTime)
        formItemEndTime.addGestureRecognizer(tapRecognizeEndTime)
        
       
        formItemStartDate.isUserInteractionEnabled = true
        formItemStartTime.isUserInteractionEnabled = true
        formItemEndTime.isUserInteractionEnabled = true
        
        
        formItemCreator.textField.delegate = self
        formItemEventName.textField.delegate = self
        
        
        formItemEventName.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        formItemCreator.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    
    func textFieldDidChange(textField: UITextField) {
        if liveValidation
        {
            _ = self.validateForm()
        }
    }
    
    
    
    func addItemToStackView(view : UIView!,height : CGFloat)
    {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        stackViewForm.addArrangedSubview(view)

    }
    @IBAction func CLClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func CLBookNow(_ sender: Any) {
        if !validateForm()
        {
            self.liveValidation = true
            return
        
        }
        
        
        let event : Event = Event()
        let user : User = User()
        user.user_name = formItemCreator.textField.text! as NSString
        event.desc = formItemEventName.textField.text! as NSString
        event.start_date = Utils.sharedInstance.convertDateToNSDate(input: Utils.sharedInstance.setTimeToDate(date: startDate, time: startTime))
        event.end_date = Utils.sharedInstance.convertDateToNSDate(input: Utils.sharedInstance.setTimeToDate(date: startDate, time: endTime))
        event.event_owner = user
        RealmHelper.sharedInstance.createEvent(event: event)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func validateForm() -> Bool
    {
        var result : Bool = true
        
        if !Validator.sharedInstance.validateEventName(text: formItemEventName.textField.text!)
        {
            result = false
            formItemEventName.showWarning()
            
        }else
        {
            formItemEventName.resetWarning()
        }
        
        if !Validator.sharedInstance.validateEventOwner(text: formItemCreator.textField.text!)
        {
            result = false
            formItemCreator.showWarning()
            
        }else
        {
            formItemCreator.resetWarning()
        }
        
        if startDate == nil
        {
            result = false
            formItemStartDate.showWarning()
        }else
        {
            formItemStartDate.resetWarning()
        }
        
        if startTime == nil
        {
            result = false
            formItemStartTime.showWarning()
        }else
        {
            formItemStartTime.resetWarning()
        }
        
        if endTime == nil
        {
            result = false
            formItemEndTime.showWarning()
        }else
        {
            formItemEndTime.resetWarning()
        }
    
        return result
    }
    
    func onFormItemTapped(gesture : UITapGestureRecognizer)
    {
        let bookFormItem = gesture.view as! BookFormItem
        switch bookFormItem {
            
        case formItemStartTime:
            self.openStartTimeChooser()
            break
        case formItemEndTime:
            self.openEndTimeChooser()
            break
        case formItemStartDate:
            self.openStartDateChooser()
            break
        
        
        default:
            break
            
        }
    }
    
    
    
    
    func openStartDateChooser()
    {
        
        
        let pickerDialog = DatePickerDialog()
        pickerDialog.show(title: "Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: Date(), maximumDate: nil, datePickerMode: .date) { (date : Date!) in
            
            if date == nil{
                return
            }
            
            self.formItemStartDate.textField.text = Utils.sharedInstance.getDateAsStringForForm(date: date)
            self.startDate = date
            self.formItemStartDate.resetWarning()
        }
        
        
    }
    
    func openStartTimeChooser()
    {
        let pickerDialog = DatePickerDialog()
        pickerDialog.show(title: "Start Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: nil, maximumDate: nil, datePickerMode: .time) { (date : Date!) in
            
            if date == nil{
                return
            }
            
            self.formItemStartTime.textField.text = Utils.sharedInstance.getTimeAsStringForForm(date: date)
            self.startTime = date
            self.formItemStartTime.resetWarning()
            
            if self.endTime != nil && self.startTime > self.endTime
            {
                self.resetEndTime()
            }
        }
    }
    
    func openEndTimeChooser()
    {
        
        
        let pickerDialog = DatePickerDialog()
        pickerDialog.show(title: "End Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: self.startTime != nil ? self.startTime : nil, maximumDate: nil, datePickerMode: .time) { (date : Date!) in
            
            if date == nil{
                return
            }
         
            self.formItemEndTime.textField.text = Utils.sharedInstance.getTimeAsStringForForm(date: date)
            self.endTime = date
            self.formItemEndTime.resetWarning()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == formItemEventName.textField)
        {
            formItemCreator.textField.becomeFirstResponder()
        }else
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    func resetEndTime()
    {
        self.endTime = nil
        formItemEndTime.reset()
        
    }
    
    
    
    
    
    
    
    
}
