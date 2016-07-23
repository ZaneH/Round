//
//  CreateEventViewController.swift
//  Round
//
//  Created by Skylar Thomas on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

let screenSize: CGRect = UIScreen.mainScreen().bounds

class CreateEventViewController: UIViewController, CLLocationManagerDelegate {
    
     var locationManager = CLLocationManager()
    var locValue = CLLocation()
    
    let rootRef = FIRDatabase.database().reference()
    let person = FIRAuth.auth()?.currentUser
    let geoFire = GeoFire(firebaseRef: FIRDatabase.database().reference().child("geoFire"))

    @IBOutlet var descripField: UITextView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var createButton: UIButton!
    
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func createEvent(sender: AnyObject) {
        
        var eventName = nameTextField.text
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePick.date)
        
        let descrip = String(descripField.text)
        
        //Firebase
        
        let root = self.rootRef.child("Events").childByAutoId()
        root.child("Date").setValue(strDate)
        root.child("Name").setValue(String(eventName))
        root.child("Description").setValue(String(descrip))
        root.child("UUID").setValue(String(person?.uid) as! String)
        
        let keyName = root.key
        
        //location
        
//        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
//            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
//            
//            currentLocation = locManager.location!
//            
//        }
        
        geoFire.setLocation(locValue, forKey: keyName)
        print(locValue)
        print("success?")
        
    }
    
    
    @IBAction func cancelEvent(sender: AnyObject) {
    }
    
    let datePick = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase location - get
//        geoFire.getLocationForKey("firebase-hq", withCallback: { (location, error) in
//            if (error != nil) {
//                print("An error occurred getting the location for \"firebase-hq\": \(error.localizedDescription)")
//            } else if (location != nil) {
//                print("Location for \"firebase-hq\" is [\(location.coordinate.latitude), \(location.coordinate.longitude)]")
//            } else {
//                print("GeoFire does not contain a location for \"firebase-hq\"")
//            }
//        })
        
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
        
        datePick.frame = CGRectMake(0, 0, screenSize.width*0.7, screenSize.height*0.2)
        datePick.center = CGPointMake(screenSize.width*0.5, screenSize.height*0.55)
        datePick.timeZone = NSTimeZone.localTimeZone()
        datePick.backgroundColor = UIColor.whiteColor()
        view.addSubview(datePick)
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
