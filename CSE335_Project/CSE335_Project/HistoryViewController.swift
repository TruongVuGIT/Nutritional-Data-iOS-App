//
//  HistoryViewController.swift
//  CSE335_Project
//
//  Created by Truong Vu on 10/17/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

//import Foundation
import UIKit
//import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var HistoryTable: UITableView!
    //var indexRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Get the amount of records in the table
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return fetchRecords();
    }
    
    
    //Add from core data to table
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NutritionCell", forIndexPath: indexPath)
 
        cell.textLabel!.text = getItemName(indexPath.row)
      
        return cell;
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        return true;
    }
 
    
    //Deleting from table and core data
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            RemoveObjectFromCoreData(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            saveCoreData();
        }
    }
    
    
    //Segue to the results page, pass in the UPC, item name, calories, fat, sodium, and sugar
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        let selectedIndex:NSIndexPath = self.HistoryTable.indexPathForCell(sender as! UITableViewCell)!
      
        
        if (segue.identifier == "ResultsSegue")
        {
            if let DetailViewController: ResultsViewController = segue.destinationViewController as? ResultsViewController {
                DetailViewController.UPC = Int(getUPCCode(selectedIndex.row))!
                DetailViewController.item_name = getItemName(selectedIndex.row)
                DetailViewController.caloriesAmount = Int(getCaloriesAmount(selectedIndex.row))!
             
                DetailViewController.fatAmount = Int(getFatAmount(selectedIndex.row))!
                DetailViewController.sodiumAmount = Int(getSodiumAmount(selectedIndex.row))!
                DetailViewController.sugarAmount = Int(getSugarAmount(selectedIndex.row))!
                
                
                
            }
        }
        
    }
 

    
}