//
//  LoginViewController.swift
//  SimpleChat
//
//  Created by ivc on 2/17/17.
//  Copyright © 2017 ivc. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userRef = FIRDatabase.database().reference().child("Users")
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let email = emailTextField.text!;
        let password = passwordTextField.text!;
        
        if(email.isEmpty || password.isEmpty )
        {
            displayMyAlertMessage("All fields are required")
            return
            
        }
        
        //let newUser = self.userRef.child(email)
        
        self.userRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if snapshot.hasChild(email){
                let user = snapshot.childSnapshotForPath(email).value as! Dictionary<String, String>
                
                if(password == user["Password"])
                {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLoggedIn")
                    NSUserDefaults.standardUserDefaults().setObject(email, forKey: "username")
                    NSUserDefaults.standardUserDefaults().synchronize();
                    
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil);
//                    self.dismissViewControllerAnimated(true, completion: nil);
                }
                else
                {
                    self.displayMyAlertMessage("Login information incorrect. Try again.")
                    return
                }
                
            }else{
                self.displayMyAlertMessage("User doesn't exist")
                return
            }
        })
    
    }
    
    func displayMyAlertMessage(messageText:String)
    {
        let myAlert = UIAlertController(title: "Alert", message:messageText, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
    }

}
