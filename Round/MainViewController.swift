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

class MainViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var viewBtn1: UIView!
    @IBOutlet var viewBtn2: UIView!
    @IBOutlet var viewBtn3: UIView!
    
    var viewGestureRecognizer1 = UITapGestureRecognizer()
    var viewGestureRecognizer2 = UITapGestureRecognizer()
    var viewGestureRecognizer3 = UITapGestureRecognizer()
    
    var names: [String] = []
    var descriptions: [String] = []
    
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
        
        /*
        PFQuery *query = [PFQuery queryWithClassName:@"Events"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
        // The find succeeded. The first 100 objects are available in objects
        } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        }];
 */
        
        let query: PFQuery = PFQuery(className: "Events")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) in
            if error == nil {
                print(objects)
                
                for object in objects! {
                    self.names.append(object["Name"] as! String)
                    self.descriptions.append(object["description"] as! String)
                }
                
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
    }

    func goToFirst()
    {
        //self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("messageView"))!, animated: true, completion: nil)
        self.performSegueWithIdentifier("toMessageView", sender: self)
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
    
    
    // MARK: - Table view data source
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 111
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, RETURN NUMBER OF SECTIONS
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, RETURN THE NUMBER OF ROWS
        if names.count < descriptions.count {
            return names.count
        } else {
            return descriptions.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableCellTableViewCell
        cell.eventTitle.text = names[indexPath.row]
        cell.eventDescription.text = descriptions[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
}