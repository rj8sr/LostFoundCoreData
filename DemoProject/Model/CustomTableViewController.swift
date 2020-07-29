//
//  CustomTableViewController.swift
//  DemoProject
//
//  Created by Rajat Sharma on 23/04/1942 Saka.
//  Copyright © 1942 InnovationM. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleSignIn
import SideMenu


class CustomTableViewController: UIViewController, MenuControllerDelegate

{
     @IBOutlet weak var sigout: UIButton!
    
    @IBOutlet weak var userid: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var images: UIImageView!
    
    
    private var sideMenu: SideMenuNavigationController?
    private let settingsController = SettingsViewController()
    private let infoController = InfoViewController()
    
    var userModel:UserModel?
    var isSideViewOpen:Bool = false
    
    
    
        override func viewDidLoad() {
        
        super.viewDidLoad()
            
            let menu = MenuController(with: SideMenuItem.allCases)
            menu.delegate = self
 sideMenu = SideMenuNavigationController(rootViewController: menu)
                   sideMenu?.leftSide = true
 SideMenuManager.default.leftMenuNavigationController = sideMenu
              SideMenuManager.default.addPanGestureToPresent(toView: view)
            
   //addChildControllers()
            
          sideMenu?.setNavigationBarHidden(true, animated: false)
         self.navigationItem.setHidesBackButton(true, animated: false)
           
            
            if let user = userModel {
            name.text=user.name
            email.text=user.email
            userid.text=user.userid
            images.sd_setImage(with: user.imageurl, completed: nil)
                                    }
       
        else
        {
       
            print("user model not found")    }
}
     @IBAction func signoout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        print( "signed out")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileVC = storyboard.instantiateViewController(withIdentifier: "View") as!
        ViewController
        
        self.navigationController?.pushViewController(profileVC, animated: true)//(profileVC, animated: true)
      //  self.navigationController?.popToRootViewController( animated: true)
    }
    
    
    
    
    @IBAction func didTap(_ sender: Any) {
        
        present(sideMenu! ,animated:  true)
    }
    
    /*private func addChildControllers() {
        addChild(settingsController)
        addChild(infoController)

        view.addSubview(settingsController.view)
        view.addSubview(infoController.view)

        settingsController.view.frame = view.bounds
        infoController.view.frame = view.bounds

        settingsController.didMove(toParent: self)
        infoController.didMove(toParent: self)

        settingsController.view.isHidden = true
        infoController.view.isHidden = true
    }*/

   

    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)

       // title = named.rawValue
        switch named {
        case .home:
            let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let sam = sigt.instantiateViewController(withIdentifier: "CustomTable") as! CustomTableViewController
                       
                       
                   navigationController?.pushViewController(sam, animated: false)
            
            settingsController.view.isHidden = true
            infoController.view.isHidden = true

        case .lost:
            
            let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let sam = sigt.instantiateViewController(withIdentifier: "infoo") as! InfoViewController
                       
                       
                   navigationController?.pushViewController(sam, animated: false)
            
            settingsController.view.isHidden = true
            infoController.view.isHidden = false

        case .found:
            
            let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let sam = sigt.instantiateViewController(withIdentifier: "helloo") as! SettingsViewController
                       
                       
                   navigationController?.pushViewController(sam, animated: false)
            
           
            settingsController.view.isHidden = false
            infoController.view.isHidden = true
        }

    }
   
 
        }

   

    


   
