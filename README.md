# Daily Expense-iOS
In this app,we try to develop regular expense of our daliy life. We entry our money begining of the month.Then,we entry our regular expense and show the regular expense.It records the regular expense.
## Home Screen
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/1.jpg)
## Login page
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/2.jpg)
## Register page
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/4.jpg)
## Main view controller
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/3.jpg)
We initially create a table.
```
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
```



First we save our total money.We Entry our total money begining of the month and save our data permantly 
using UserDefult.
```
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
```
Then we take regular expense and cut down from the total money.Here ,we use SQLITE to store our data.We use displayAlertMessag to show User message. We check validatation of the data.First textbox take only string value and second textbox take only integer value.Then,we insert our data try2 table.
```
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
```

We clear our our data from database.
```

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
```
In readValues function ,we load our data in UITableView.
```
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
```

## ViewController.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/5.jpg)
## Main storyboard
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/6.jpg)
## ViewController2.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/7.jpg)
## LoginViewController.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/8.jpg)


