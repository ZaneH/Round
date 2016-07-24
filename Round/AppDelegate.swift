//
//  AppDelegate.swift
//  Round
//
//  Created by Zane Helton on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import Parse

let prefs = NSUserDefaults.standardUserDefaults()

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false);
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "round_app"
            $0.server = "https://round-the-app.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        //let loc1: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.794920, longitude: -122.394506)
        //let loc2: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.776222, longitude: -122.418033)
        //print("LOOK AT ME!!!! \n Distance: \(getMeterDistance(loc1, location2: loc2))")

        
        //Set up storyboard
        let startViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        startViewController = storyboard.instantiateViewControllerWithIdentifier("SplashViewController") as! UIViewController

        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController;
        self.window?.makeKeyAndVisible()
		return true
	}
    
}
public func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
func runAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue(), block)
}

