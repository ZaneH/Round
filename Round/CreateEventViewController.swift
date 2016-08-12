//
//  CreateEventViewController.swift
//  Round
//
//  Created by Skylar Thomas on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import Parse

let screenSize: CGRect = UIScreen.mainScreen().bounds


class CreateEventViewController: UIViewController, CLLocationManagerDelegate, UITextViewDelegate {
    
     var locationManager = CLLocationManager()
    var locValue = CLLocation()
    
    var hasEnteredBefore = Bool(false)
    
    @IBOutlet var datePick: UIDatePicker!


    @IBOutlet var descripField: UITextView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var createButton: UIButton!
    
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func createEvent(sender: AnyObject) {
        
        var eventName = nameTextField.text!
        var dateFormatter = NSDateFormatter()
        
        var dateFormatter2 = NSDateFormatter()
        
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = .NoStyle
        
        dateFormatter2.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter2.dateStyle = .NoStyle
        
        print(dateFormatter.stringFromDate(datePick.date))
        print(dateFormatter2.stringFromDate(datePick.date))
        
        let strDate = dateFormatter.stringFromDate(datePick.date)
        let strTime  = dateFormatter2.stringFromDate(datePick.date)
        
        let descrip = String(descripField.text)
        let locationValue = PFGeoPoint(location: Constants.locationManager.location)
        
        print(dateFormatter.dateStyle)
        
        //save event
        let newEvent = PFObject(className: "Events")
        newEvent["Name"] = eventName
        newEvent["description"] = descrip
        newEvent["location"] = locationValue
        newEvent["date"] = strDate
        newEvent["time"] = strTime
        
        newEvent["creatorName"] = PFUser.currentUser()!["fullName"]
        
       newEvent.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        
         self.performSegueWithIdentifier("dismissCreate", sender: self)
        }
        
    }
    
    
    @IBAction func cancelEvent(sender: AnyObject) {
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        if !hasEnteredBefore {
            hasEnteredBefore = !hasEnteredBefore
        textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         descripField.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        
        createButton.layer.cornerRadius = 15
        createButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        createButton.layer.borderWidth = 1.5
        createButton.layer.borderColor = UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1).CGColor
        createButton.setTitleColor(UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1), forState: UIControlState.Normal)
        
        
        
        cancelButton.layer.cornerRadius = 15
        cancelButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0).CGColor
        cancelButton.setTitleColor(UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0), forState: UIControlState.Normal)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locValue = manager.location!.coordinate
        locValue = manager.location!
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
