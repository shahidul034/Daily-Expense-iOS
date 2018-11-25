//
//  LoginViewController.swift
//  LoginRegistrationA260
//
//  Created by kuet on 8/10/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
   
    
    
   
    
   
   
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var passsword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "name.jpg")!)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
  
    @IBAction func Logintest(_ sender: Any) {
        let user = username.text
        let pass = passsword.text
        
        //retrieve from database
        let storedName=UserDefaults.standard.string(forKey: "UserName")
        let storedPassword=UserDefaults.standard.string(forKey: "UserPassword")
        
        //check if match
        if (user==storedName && pass == storedPassword){
           // displayAlertMessage(userMessage: "successful")
            print("Yes logged")
            
            self.performSegue(withIdentifier: "logintospend", sender: self)
                
                
           
           
           
            
        }
        else{
           displayAlertMessage(userMessage: "not sucessful your username and/or password is wrong!!")
            print("no logged")
        }
        //sucessful
    }
    func displayAlertMessage(userMessage: String) {
        let alert = UIAlertController(title: "Login Status", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    
    
    
}
