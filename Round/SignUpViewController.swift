//
//  SignUpViewController.swift
//  Round
//
//  Created by Zane Helton on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var firstNameTextField: UITextField!
	
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
	
	@IBAction func didTapSignUp(sender: AnyObject) {
		FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
			if let error = error {
				// spit the error to the user
				let errorAlertController = UIAlertController.init(title: "Whoops!", message: error.localizedDescription, preferredStyle: .Alert);
				errorAlertController.addAction(UIAlertAction.init(title: "Dismiss", style: .Default, handler: nil));
				
				self.presentViewController(errorAlertController, animated: true, completion: nil);
				return;
			}
			
			// tell the user they've been signed up
			let successAlertController = UIAlertController.init(title: "Success", message: "You've been registered successfully! Continue to the Sign In page.", preferredStyle: .Alert);
			successAlertController.addAction(UIAlertAction.init(title: "Dismiss", style: .Default, handler: { (alert) in
				self.dismissViewControllerAnimated(true, completion: nil);
			}));
			
			self.presentViewController(successAlertController, animated: true, completion: nil);
		});
	}
}
