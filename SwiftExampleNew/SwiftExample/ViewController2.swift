//
//  ViewController.swift
//  basic_api
//
//  Created by kuet on 30/10/18.
//  Copyright © 2018 kuet. All rights reserved.
//

import UIKit
struct websites: Decodable{
    let name :String
    let description:String
    let courses:[Course]
    
}
struct Course : Decodable{
    let id :Int
    let imageUrl:String
    let link:String
    let name:String
    let number_of_lessons:Int
    
    /*init(json:[String:Any]){
     id=json["id"] as? Int ?? -1
     imageUrl=json["imageUrl"] as? String ?? ""
     link = json["link"] as? String ?? ""
     name = json["name"] as? String ?? ""
     num_of_les = json["number_of_lessons"] as? Int ?? -1
     } */
}
class ViewController2: UIViewController {
    
    
    @IBOutlet weak var imagefield2: UIImageView!
    
    @IBOutlet weak var Demotext2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "name.jpg")!)
        
        let url=URL(string: "https://api.letsbuildthatapp.com/jsondecodable/website_description" )!
        let task=URLSession.shared.dataTask(with: url){
            (data,response,Error) in
            do {
                /*  let json=try
                 JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                 let course = Course(json:json!)
                 print(course.name)
                 //print(json)
                 DispatchQueue.main.async {
                 self.Demotext.text=course.name
                 
                 
                 } */
                let website=try
                    JSONDecoder().decode(websites.self, from: data!)
                print(website.description)
                // print(json)
                DispatchQueue.main.async {
                    self.Demotext2.text=website.description
                }
                if(website.description==""){
                     self.Demotext2.text="no basic api parsing"
                }
                
                
            }
            catch let jsonerror{
                
                print("json error ",jsonerror)
                
                
            }
            
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

