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
	
    override func viewDidLoad() {
        super.viewDidLoad()
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
