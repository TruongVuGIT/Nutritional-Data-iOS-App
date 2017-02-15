//
//  ResultsViewController.swift
//  CSE335_Project
//
//  Created by Truong Vu on 10/17/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    //Variables needed to print out to View
    var UPC:Int = 0
    var item_name:String = ""
    var caloriesAmount:Int = 0
    var fatAmount:Int = 0
    var sodiumAmount:Int = 0
    var sugarAmount:Int = 0
    
    //Textbox Outputs
    @IBOutlet weak var UPCoutput: UITextField!
    @IBOutlet weak var ItemOutput: UITextField!
    @IBOutlet weak var FatOutput: UITextField!
    @IBOutlet weak var SodiumOutput: UITextField!
    @IBOutlet weak var SugarOutput: UITextField!
    @IBOutlet weak var CaloriesOutput: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        
    }
    //When the View loads, load in the nutritional values into the textboxes
    override func viewDidLoad() {
        super.viewDidLoad()
        UPCoutput.text = String(UPC)
        ItemOutput.text = item_name
        CaloriesOutput.text = String(caloriesAmount)
        FatOutput.text = String(fatAmount)
        SodiumOutput.text = String(sodiumAmount)
        SugarOutput.text = String(sugarAmount)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Search Button - Unneeded?
    @IBAction func SearchBtn(sender: AnyObject)
    {
        
    }
    
    //Segue to the WebView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        // let selectedIndex:NSIndexPath = self.FavoritesTable.indexPathForCell(sender as! UITableViewCell)!
        
        if (segue.identifier == "search")
        {
            if let DetailViewController: WebViewController = segue.destinationViewController as? WebViewController {
                //DetailViewController.selectedName = GetRestaurantName(selectedIndex.row);
                DetailViewController.item_name = item_name;
    
                
            }
        }
    }
}