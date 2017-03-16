//
//  RegisterPageViewController.swift
//  SimpleChat
//
//  Created by ivc on 2/17/17.
//  Copyright © 2017 ivc. All rights reserved.
//

import UIKit
import Firebase

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    var userRef: FIRDatabaseReference!
    
    var user: Dictionary<String, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userRef = FIRDatabase.database().reference().child("Users")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        let displayName = displayNameTextField.text!;
        let email = emailTextField.text!;
        let password = passwordTextField.text!;
        let confirmPassword = confirmPasswordTextField.text!;
        
        
        if(displayName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        {
            displayMyAlertMessage("All fields are required");
            return;
        }
        
        if(password != confirmPassword){
            displayMyAlertMessage("Passwords do not match");
            return;
        }
        
        self.userRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if !snapshot.hasChild(email){
                let newUser = self.userRef.child(email)
                
                let userItem = [
                    "Name": displayName,
                    "Email": email,
                    "Password": password,
                ]
                
                newUser.setValue(userItem)
                
                let myAlert = UIAlertController(title: "Alert", message:"Registration is success.", preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in self.dismissViewControllerAnimated(true, completion: nil);
                }
                
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated: true, completion: nil);
                
            }else{
                self.displayMyAlertMessage("User is exist")
                return
            }
            
            
        })
        
    }
    @IBAction func backLoginButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func displayMyAlertMessage(messageText:String)
    {
        let myAlert = UIAlertController(title: "Alert", message:messageText, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
}
