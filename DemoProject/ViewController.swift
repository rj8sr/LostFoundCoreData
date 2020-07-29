//
//  ViewController.swift
//  DemoProject
//
//  Created by Rajat Sharma on 23/04/1942 Saka.
//  Copyright © 1942 InnovationM. All rights reserved.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController,GIDSignInDelegate {
    
    @IBOutlet weak var buttonSign: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController =  self 
        GIDSignIn.sharedInstance()?.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func SignIn(_ sender: Any) {
        
    GIDSignIn.sharedInstance()?.signIn()
    
    
    }
    
      func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if error != nil{
            print(error.debugDescription)
                        }
          else{
            if let user = user{
                let usermodel = UserModel(name: user.profile.name, email: user.profile.email, userid: user.userID, imageurl: user.profile.imageURL(withDimension: UInt(200)))
                print("\(usermodel)")
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let profileVC = storyboard.instantiateViewController(withIdentifier: "CustomTable") as!
                CustomTableViewController
                profileVC.userModel = usermodel
                self.navigationController?.pushViewController(profileVC, animated: true)//(profileVC, animated: true)
            }}
                
            }
            
            
            
        }
        
      
      
  
