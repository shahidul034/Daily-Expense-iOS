//
//  ViewController.swift
//  SwiftExample
//
//
//  
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var output: UILabel!
    let userdef=UserDefaults.standard;
    var db: OpaquePointer?
    var heroList = [Hero]()
    
    @IBOutlet weak var total_money: UITextField!
    @IBOutlet weak var tableViewHeroes: UITableView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPowerRanking: UITextField!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let powerRanking = textFieldPowerRanking.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(name?.isEmpty)!{
            displayAlertMessage(userMessage: "You must fill up the field!!")
            return
        }
        
        if(powerRanking?.isEmpty)!{
            displayAlertMessage(userMessage: "You must fill up the field!!")
            return
        }
        
        ////////////
        var num : Int = 0
        var num2 : Int = 0
        
        for x in  powerRanking! {
            num2=num2+1
            if (x=="0" || x=="1" || x=="2" || x=="3" || x=="4" || x=="5" || x=="6" || x=="7" || x=="8" || x=="9" )
            {
               num=num+1
            }
        }
        if (num != num2)
        {
            displayAlertMessage(userMessage: "Integer number must be entered!!")
            return
        }
        
        
        
        /////////////
        var dat=userdef.string(forKey: "cnt")
        let myInt = Int(dat!)
        
        let myInt2 = Int(powerRanking!)
       
         let val = myInt! - myInt2!
        print("ans: ",name)
        
        var myString2 = String(val)
        output.text="Remaining: " + myString2
        userdef.set(myString2, forKey: "cnt")
        
        
       
        ////////////////
       
        
        /*if()
        {
            displayAlertMessage(userMessage: "Passwords didn't match")
            return
        }*/
        
        //////////////
        //print(name," ",powerRanking)
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO try2 (name, powerrank) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        
        if sqlite3_bind_int(stmt, 2, (powerRanking! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        

        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        textFieldName.text=""
        textFieldPowerRanking.text=""
        
        readValues()

        print("Data saved successfully")
    }
    
    @IBAction func saved_total(_ sender: Any) {
        let money = total_money.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        var num : Int = 0
        var num2 : Int = 0
        
        for x in  money! {
            num2=num2+1
            if (x=="0" || x=="1" || x=="2" || x=="3" || x=="4" || x=="5" || x=="6" || x=="7" || x=="8" || x=="9" )
            {
                num=num+1
            }
        }
        if (num != num2)
        {
            displayAlertMessage(userMessage: "Integer number must be entered!!")
            return
        }
        userdef.set(money, forKey: "cnt")
        print("Total money saved sucessfully")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let hero: Hero
        hero = heroList[indexPath.row]
       
        
        //print("check: ",hero.name)
       
        let x : Int = hero.powerRanking
        var myString = String(x)
        
        //let x3 : Int = hero.total
        //var myString3 = String(x3)
        var dat=userdef.string(forKey: "cnt")
        cell.textLabel?.text = hero.name! + " spend: " + myString
        return cell
    }
    
    
    func readValues(){
        heroList.removeAll()

        let queryString = "SELECT * FROM try2"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            
            let powerrank = sqlite3_column_int(stmt, 2)
            
            //print("enwcheck: ",name," ",name2)
            heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
        self.tableViewHeroes.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "name.jpg")!)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("HeroesDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS try2 (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil,nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            print("/////////////////////////////////")
        }
        
        
        
        
        readValues()
        
        
    }
    ////////////
   
    ///////////
    
    @IBAction func delete_data(_ sender: Any) {
        let queryString = "delete FROM try2"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing delete: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure deleting hero: \(errmsg)")
            return
        }
        readValues()
        
        
    }
    func displayAlertMessage(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

