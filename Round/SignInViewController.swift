//
//  SignInViewController.swift
//  
//
//  Created by Zane Helton on 7/23/16.
//
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func didTapLogin(sender: AnyObject) {
		FIRAuth.auth()?.signInWithEmail(usernameTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
			if let error = error {
				let errorAlertController = UIAlertController.init(title: "Whoops!", message: error.localizedDescription, preferredStyle: .Alert);
				errorAlertController.addAction(UIAlertAction.init(title: "Dismiss", style: .Default, handler: nil));
				self.presentViewController(errorAlertController, animated: true, completion: nil);
				return;
			}
			
			let successAlertController = UIAlertController.init(title: "Success", message: "You're signed in.", preferredStyle: .Alert);
			self.presentViewController(successAlertController, animated: true, completion: nil);
		});
	}
}
