//
//  MainViewController.swift
//  Round
//
//  Created by Skylar Thomas on 7/24/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//
import MapKit
import UIKit
import Parse
import CoreLocation

class MainViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate {

    @IBOutlet var viewBtn1: UIView!
    @IBOutlet var viewBtn2: UIView!
    
    @IBOutlet var viewBtn3: UIView!
    
    var viewGestureRecognizer1 = UITapGestureRecognizer()
    var viewGestureRecognizer2 = UITapGestureRecognizer()
    var viewGestureRecognizer3 = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewGestureRecognizer1 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToFirst))
        view.userInteractionEnabled = true
        viewBtn1.addGestureRecognizer(viewGestureRecognizer1)
        
        viewGestureRecognizer2 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToSecond))
        view.userInteractionEnabled = true
        viewBtn2.addGestureRecognizer(viewGestureRecognizer2)
        
        viewGestureRecognizer3 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToThird))
        view.userInteractionEnabled = true
        viewBtn3.addGestureRecognizer(viewGestureRecognizer3)
        
        //location shit

        Constants.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        Constants.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            Constants.locationManager.delegate = self
            Constants.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            Constants.locationManager.startUpdatingLocation()
        }
        
        print("CLLocationManager enabled")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToFirst()
    {
        self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("mainView"))!, animated: true, completion: nil)
    }
    
    func goToSecond()
    {
        self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("createEvent"))!, animated: true, completion: nil)
    }
    func goToThird()
    {
        self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("eventSearch"))!, animated: true, completion: nil)
    }
    
    // Manages location of user
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        print("My Location = \(locValue.latitude) \(locValue.longitude)")
        Constants.myLocation = locValue
        
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = PFUser.currentUser()
    
    
    var usersArray: [PFUser] = []
    
    
//    func fillUserArray() {
//        usersArray = []
//        
//        let query = PFUser.query()!
//        query.whereKey("atHome", equalTo: true)
//        
//        query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
//            for user in objects! {
//                self.usersArray.append((user as? PFUser)!) //fixed async
//            }
//        });
//        
//        tableView.reloadData()
//    }
    
    
//    func updateUserAtHome() {
//        
//        
//        
//        if user!["atHome"] as! Bool == true {
//            //User is HOME!!!
//            print("USER IS HOME")
//            // Do we add him to the array??
//            if !usersArray.contains(user!) {
//                // Add to the array
//                usersArray.append(user!)
//                
//                user?.saveInBackground()
//                
//                
//                
//            }
//            else {
//                // do nothing bc hes already in the array
//            }
//            
//        }
//            
//        else {
//            print("User is not home")
//            
//            //He is not home!!! Is he in the array??
//            if usersArray.contains(user!) {
//                // if he is, then take him out of the array
//                usersArray.removeAtIndex(usersArray.indexOf(user!)!)
//                user?.saveInBackground()
//            }
//            else {
//                print("User is not home")
//                // do nothing bc hes already out of the array
//            }
//            
//        }
//        tableView.reloadData()
//    }
    
    
    
    // MARK: - Table view data source
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        else {
            return 70
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, RETURN NUMBER OF SECTIONS
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, RETURN THE NUMBER OF ROWS
        
        
        print("users in home: \(usersArray.count)")
        
        return usersArray.count + 1
    }
    
    
    
    
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
////        if indexPath.row == 0 {
////            let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! EventTableCellTableViewCell
////            
////            let center = CLLocationCoordinate2D(latitude: Constants.myDormLocation.latitude, longitude: Constants.myDormLocation.longitude)
////            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
////            
////            let objectAnnotation = MKPointAnnotation()
////            objectAnnotation.coordinate = center
////            objectAnnotation.title = "HPE"
////            cell.mapView.addAnnotation(objectAnnotation)
////            
////            
////            cell.mapView.setRegion(region, animated: true)
////            
////            return cell
////        }
////        else {
////            let cell: UserTableViewCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
////            
////            let userAtHome = usersArray[indexPath.row - 1]
////            
////            if(userAtHome.username == PFUser.currentUser()?.username)
////            {
////                
////                cell.layer.backgroundColor = UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 0.5).CGColor
////                //cell.textLabel?.textColor = UIColor.whiteColor()
////                cell.userFullNameLabel?.textColor = UIColor.whiteColor()
////                
////                //                let logOut = UITableViewRowAction(style: .Normal, title: "Log Out") { action, index in
////                //                    print("log out button tapped")
////                //                    PFUser.logOut()
////                //
////                //                }
////                //                logOut.backgroundColor = UIColor.lightGrayColor()
////                //                return[logOut]
////            }
////            
////            // print("Index is at: \(indexPath.row - 1)")
////            
////            // edit label to full name of user
////            let first = userAtHome["firstName"]
////            let last = userAtHome["lastName"]
////            
////            
////            
////            cell.userFullNameLabel.text = String("\(first) \(last)")
////            cell.profileImage2.image = UIImage(named: "round_logo")
//        
//            
//            // return cell
//            return cell
//            
//        }
    
        
    }
    
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
