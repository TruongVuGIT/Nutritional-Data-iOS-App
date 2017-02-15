//
//  ViewController.swift
//  CSE335_Project
//
//  Created by Truong Vu on 10/17/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables needed to print output for View
    var UPC:Int = 0
    var item_name:String = ""
    var caloriesAmount:Int = 0
    var fatAmount:Int = 0
    var sodiumAmount:Int = 0
    var sugarAmount:Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
       // DeleteCoreData();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    @IBOutlet weak var UPCInput: UITextField!
    
    //Get nutritional value
    @IBAction func getNutritionBtn(sender: AnyObject)
    {
       
       if (UPCInput.text == "")
       {
        let alert = UIAlertController(title: "Error", message: "UPC code is empty", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true)
        {
            
        }
        }
        else
       {
        UPC = Int(UPCInput.text!)!
     
        (UPC, item_name, caloriesAmount, fatAmount, sodiumAmount, sugarAmount) = getNutrition(UPC)

        if getAPISuccess() == true
        {
        addToCoreData(UPC, item_name: item_name, caloriesAmount:caloriesAmount , fatAmount: fatAmount, sodiumAmount: sodiumAmount, sugarAmount: sugarAmount)
            //APIsuccess = false
            APISuccessToFalse();
        }
        
        }
        
    }
    
    
    
    //Segue to the results page
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {

        
        if (segue.identifier == "ResultsSegue")
        {
            if let DetailViewController: ResultsViewController = segue.destinationViewController as? ResultsViewController {
                if (item_name == "Item ID or UPC was invalid")
                {
                 
                        let alert = UIAlertController(title: "Error", message: "UPC code is invalid and/or Product not found", preferredStyle: .Alert)
                        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            // ...
                        }
                        alert.addAction(OKAction)
                        self.presentViewController(alert, animated: true)
                        {
                            
                        }
    

                }
                else
                {
                DetailViewController.UPC = UPC;
                DetailViewController.item_name = item_name;
                DetailViewController.caloriesAmount = caloriesAmount
                DetailViewController.fatAmount = fatAmount
                DetailViewController.sodiumAmount = sodiumAmount
                DetailViewController.sugarAmount = sugarAmount
                }
         
            }
        }
        
    }
    
   }

