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

## ViewController.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/5.jpg)
## Main storyboard
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/6.jpg)
## ViewController2.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/7.jpg)
## LoginViewController.swift
![alt text](https://github.com/shahidul034/ios2/blob/master/ios2/8.jpg)


