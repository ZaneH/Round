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
	
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        
        
        logInButton.layer.cornerRadius = 15
        logInButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        logInButton.layer.borderWidth = 1.5
        logInButton.layer.borderColor = UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1).CGColor
        logInButton.setTitleColor(UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1), forState: UIControlState.Normal)
        
        
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0).CGColor
        signUpButton.setTitleColor(UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0), forState: UIControlState.Normal)

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
