//
//  SignUpViewController.swift
//  Round
//
//  Created by Zane Helton on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    // let keyboard fall when push anywhere
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        // Do any additional setup after loading the view.
        cancelButton.layer.cornerRadius = 15
        cancelButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 1).CGColor
        cancelButton.setTitleColor(UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 1), forState: .Normal)
        
        if cancelButton.highlighted {
            cancelButton.layer.backgroundColor = UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 1).CGColor
            cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        
        
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0).CGColor
        signUpButton.setTitleColor(UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0), forState: .Normal)
        
        if signUpButton.highlighted {
            signUpButton.layer.backgroundColor = UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0).CGColor
            signUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpPressed(sender: UIButton) {
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        user["emailVerified"] = true
        user.email = email.text
        user["firstName"] = firstName.text
        user["lastName"] = lastName.text
        user["fullName"] = firstName.text! + " " + lastName.text!
        
        
        if username.text != "" && password.text != "" && email.text != "" && firstName.text != "" && lastName.text != "" {
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if error != nil {
                    //                    _ = error.userInfo["error"] as? NSString // should delete
                    // Show the errorString somewhere and let the user try again.
                    let alert = UIAlertController(title: "Sorry", message: "Try to enter a valid email address.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                } else {
                    // Hooray! Let them use the app now.
                    print("success")
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("mainView")
                    self.showViewController(vc as! UIViewController, sender: vc)
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Sorry", message: "You need to fill in every field.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
}
