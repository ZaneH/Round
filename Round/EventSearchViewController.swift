//
//  UserProfileViewController.swift
//  Pods
//
//  Created by Skylar Thomas on 6/25/16.
//
//

import UIKit
import Parse
import CoreLocation
import MapKit

class EventSearchViewController: UIViewController {
    
    @IBOutlet var viewBtn1: UIView!
    @IBOutlet var viewBtn2: UIView!
    
    @IBOutlet var viewBtn3: UIView!
    
    var viewGestureRecognizer1 = UITapGestureRecognizer()
    var viewGestureRecognizer2 = UITapGestureRecognizer()
    var viewGestureRecognizer3 = UITapGestureRecognizer()
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var locationView: UIView!
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var smallMap: MKMapView!
    @IBOutlet var addLocationBtn: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    let userSearch = UISearchBar()
    
    
    let imagePicker = UIImagePickerController()
    
    var viewGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewGestureRecognizer1 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToFirst))
        view.userInteractionEnabled = true
        viewBtn1.addGestureRecognizer(viewGestureRecognizer1)
        
        viewGestureRecognizer2 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToSecond))
        view.userInteractionEnabled = true
        viewBtn2.addGestureRecognizer(viewGestureRecognizer2)
        
        viewGestureRecognizer3 = UITapGestureRecognizer(target:self, action:#selector(MainViewController.goToThird))
        view.userInteractionEnabled = true
        viewBtn3.addGestureRecognizer(viewGestureRecognizer3)
        
        //important stuff
        
        let textFieldInsideUISearchBar = userSearch.valueForKey("searchField") as? UITextField
        textFieldInsideUISearchBar?.font = UIFont(name: "VarelaRound", size: 15)
        textFieldInsideUISearchBar?.textColor = colorWithHexString("F46476")
        
        //SearchBar Placeholder
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.valueForKey("placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.font = UIFont(name: "VarelaRound", size: 15)
        
        locationView.hidden = true;
        locationView.layer.cornerRadius = 8
        shadowView.hidden = true
        profileView.layer.cornerRadius = 8
        profileView.hidden = true;
        
        userSearch.tintColor = colorWithHexString("F46476")
        userSearch.barTintColor = UIColor.clearColor()
        userSearch.backgroundImage = UIImage(named: "clear")
        
        
        addLocationBtn.layer.cornerRadius = 14
        
        // Do any additional setup after loading the view.
        
        viewGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(EventSearchViewController.removeOverView(_:)))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(viewGestureRecognizer)
        viewGestureRecognizer.enabled = false
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func usersProfileView(user: PFUser)
    {
        if(profileView.hidden)
        {
            profileView.hidden = false
            
            //profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            
            self.profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.profileView.alpha = 0.0;
            UIView.animateWithDuration(0.25, animations: {
                self.profileView.alpha = 1.0
                self.profileView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.viewGestureRecognizer.enabled = true
                self.shadowView.hidden = false
                self.dismissKeyboard()
                //self.keyboardGestureRecognizer.enabled = true
            });
        }
        usernameLabel?.text = user.username
        nameLabel?.text = "\(user["firstName"]) \(user["lastName"])"
        
    }
    func removeOverView(sender: AnyObject)
    {
            removeLocationView()

    }
    
    func removeProfileView()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.profileView.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.profileView.hidden = true
                    self.viewGestureRecognizer.enabled = false
                    self.shadowView.hidden = true
                    //self.keyboardGestureRecognizer.enabled = false
                }
        });
        
    }
    
    func setViewAddress(add: String)->Void
    {
        let address = add
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error!!!", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print(coordinates)
                
                //set map
                let center = coordinates
                let span = MKCoordinateSpanMake(0.035, 0.035)
                let region = MKCoordinateRegion(center: center, span: span)
                self.smallMap.setRegion(region, animated: true)
                
                var annotation = MKPointAnnotation()
                annotation.coordinate = center
                self.smallMap.addAnnotation(annotation)
                
                
            }
        })
        
        
    }
    
    func locationViewActivate(location: PFObject)
    {
        if(locationView.hidden)
        {
            locationView.hidden = false
            
            //profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            
            self.locationView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.locationView.alpha = 0.0;
            UIView.animateWithDuration(0.25, animations: {
                self.locationView.alpha = 1.0
                self.locationView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.viewGestureRecognizer.enabled = true
                self.shadowView.hidden = false
                self.dismissKeyboard()
                //self.keyboardGestureRecognizer.enabled = true
            });
        }
        
        
        addressLabel?.text = "\(location["address"])"
        setViewAddress("\(location["address"])")
        
    }
    func removeLocationView() {
        UIView.animateWithDuration(0.25, animations: {
            self.locationView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.locationView.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.locationView.hidden = true
                    self.viewGestureRecognizer.enabled = false
                    self.shadowView.hidden = true
                    //self.keyboardGestureRecognizer.enabled = false
                }
        });
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        profileImage.image = image
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is new---
    
    // stores all the users that match the current search query
    var users: [PFUser]?
    
    var locations: [PFObject]?
    
    /*
     This is a local cache. It stores all the users this user is following.
     It is used to update the UI immediately upon user interaction, instead of
     having to wait for a server response.
     */
    var followingUsers: [PFUser]? {
        didSet {
            /**
             the list of following users may be fetched after the tableView has displayed
             cells. In this case, we reload the data to reflect "following" status
             */
            tableView.reloadData()
        }
    }
    
    // the current parse query
    var query: PFQuery? {
        didSet {
            // whenever we assign a new query, cancel any previous requests
            // you can use oldValue to access the previous value of the property
            oldValue?.cancel()
        }
    }
    
    // this view can be in two different states
    enum State {
        case DefaultMode
        case SearchMode
    }
    
    
    // whenever the state changes, perform one of the two queries and update the list
    var state: State = .DefaultMode {
        didSet {
            switch (state) {
                
            case .SearchMode:
                let searchText = userSearch.text ?? ""

                    query = ParseHelper.searchLocations(searchText, completionBlock:updateList)
                //keyboardGestureRecognizer.enabled = true //test
                
                
            case .DefaultMode:
                print("nothing")
                //keyboardGestureRecognizer.enabled = false
            }
        }
    }
    // MARK: Update userlist
    
    /**
     Is called as the completion block of all queries.
     As soon as a query completes, this method updates the Table View.
     */
    func updateList(results: [PFObject]?, error: NSError?) {
        
            self.locations = results
        self.tableView.reloadData()
        
    }
    
}


// MARK: TableView Data Source

extension EventSearchViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

            let location = self.locations![indexPath.row]
            locationViewActivate(location)
        
        
        // set labels and imageview below
        
    }
}

extension EventSearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.locations?.count ?? 0

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSearchCell") as! UserSearchTableCell
        
            let location = locations![indexPath.row]
            cell.location = location
        
        /*if let followingUsers = followingUsers {
         // check if current user is already following displayed user
         // change button appereance based on result
         cell.canFollow = !followingUsers.contains(user)
         }*/
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: Searchbar Delegate

extension EventSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        
        state = .SearchMode
        print("func 2")
        
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        state = .DefaultMode
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    
            ParseHelper.searchLocations(searchText, completionBlock:updateList)
    
    }}

// MARK: FriendSearchTableViewCell Delegate

extension EventSearchViewController: FriendSearchTableViewCellDelegate {
    
    func cell(cell: UserSearchTableCell, didSelectFollowUser user: PFUser) {
        //        ParseHelper.addFollowRelationshipFromUser(PFUser.currentUser()!, toUser: user)
        //        // update local cache
        //        followingUsers?.append(user)
    }
    //
    func cell(cell: UserSearchTableCell, didSelectUnfollowUser user: PFUser) {
        //        if let followingUsers = followingUsers {
        //            ParseHelper.removeFollowRelationshipFromUser(PFUser.currentUser()!, toUser: user)
        //            // update local cache
        //            self.followingUsers = followingUsers.filter({$0 != user})
        //        }
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
