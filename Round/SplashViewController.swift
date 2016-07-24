//
//  SplashViewController.swift
//  Round
//
//  Created by Skylar Thomas on 7/24/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 4.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class SplashViewController: UIViewController {
    
    let iconImg = UIImageView(image: UIImage(named: "round_logo"))
    let roundText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImg.frame = CGRectMake(0, 0, screenSize.width * (110/330), screenSize.width * (110/330))
        iconImg.center = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.38)
        view.addSubview(iconImg)
        iconImg.alpha = 0.0
        
        roundText.text = "round"
        roundText.font = UIFont(name: "VarelaRound", size: screenSize.height * (45/568))
        //roundText.textColor = colorWithHexString("#3E3D3F")
        roundText.textColor = UIColor.whiteColor()
        //scrollLabel.textColor = UIColor.blackColor()
        roundText.frame = CGRectMake(0, 0, screenSize.width * 0.45, screenSize.height * (100/568))
        //roundText.center = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.535)
        roundText.center = CGPointMake(screenSize.width * 1.25, screenSize.height * 0.55)
        roundText.textAlignment = NSTextAlignment.Center
        view.addSubview(roundText)
        
        
        inAnimation()
    }
    
    //im so tired this is hilarious
    func inAnimation()
    {
       UIView.animateWithDuration(0.65, delay: 0, options: .CurveEaseOut, animations: {
            
            self.iconImg.alpha = 1.0
               self.iconImg.rotate360Degrees()
                
            }, completion: { finished in
                
                UIView.animateWithDuration(0.7, delay: 0.4, usingSpringWithDamping:
                    0.58, initialSpringVelocity: 1.1, options: [], animations: {
                        
                        self.roundText.center.x -= screenSize.width * 0.75
                        
                    }, completion: { finished in
                       
                        runAfterDelay(1.2)
                        {
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("SignInViewController")
                        self.showViewController(vc as! UIViewController, sender: vc)
                        }
                })
                
        })

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
