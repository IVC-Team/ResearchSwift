//
//  Common.swift
//  SimpleChat
//
//  Created by ivc on 3/1/17.
//  Copyright © 2017 ivc. All rights reserved.
//
import UIKit
import Foundation

func displayMyAlertMessage(messageText:String)
{
    let myAlert = UIAlertController(title: "Alert", message:messageText, preferredStyle: UIAlertControllerStyle.Alert);
    
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    
    myAlert.addAction(okAction);
    
    presentViewController(myAlert, animated: true, completion: nil);
}