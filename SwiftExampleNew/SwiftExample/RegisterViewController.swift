//
//  RegisterViewController.swift
//  LoginRegistrationA260
//
//  Created by kuet on 8/10/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    
    
   
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "name.jpg")!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func Register(_ sender: Any) {
        let password = Password.text
        let user = username.text
        let confirmPassword = ConfirmPassword.text
        
        //validation
        
        if((user ?? "").isEmpty || (password ?? "").isEmpty || (confirmPassword ?? "").isEmpty)
        {
            displayAlertMessage(userMessage: "All fields are required")
            return
            
        }
        if(password != confirmPassword)
        {
            displayAlertMessage(userMessage: "Passwords didn't match")
            return
        }
        
        //store
        
        UserDefaults.standard.set(password, forKey: "UserPassword")
        UserDefaults.standard.set(user, forKey: "UserName")
        
        //success
        let alert = UIAlertController(title: "Congrats!", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Thanks", style: UIAlertActionStyle.default, handler: {action in
            self.performSegue(withIdentifier: "RegisterToHomePage", sender: self)
            })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func displayAlertMessage(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
