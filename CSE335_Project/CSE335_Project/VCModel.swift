//
//  VCModel.swift
//  CSE335_Project
//
//  Created by Truong Vu on 10/17/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit


//Variables needed for TableView and API access
let insertContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
var viewContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
var fetchResults = [NutritionEntity]()
let ent = NSEntityDescription.entityForName("NutritionEntity", inManagedObjectContext: insertContext)
var APIsuccess = false;

//Get the nutrition value, use nutritionix API, and use jsonQuery
//Pass in the UPC code, return UPC, item name, calories, fat, sodium, sugar,
func getNutrition(UPC:Int) -> (Int, String, Int, Int, Int, Int)
{
    

    var urlAsString = "https://api.nutritionix.com/v1_1/item?upc=" + String(UPC) + "&appId=9a69c9b1&appKey=27673a0940161ae3eade89d9670ba3f9"
    
    //print (urlAsString)
    
    var item_name:String = ""
    var caloriesAmount:Int = 0
    var fatAmount:Int = 0
    var sodiumAmount:Int = 0
    var sugarAmount:Int = 0
   
    
    let semaphore = dispatch_semaphore_create(0)
    
    let url = NSURL(string: urlAsString)!
    let urlSession = NSURLSession.sharedSession()
    
    let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
        if (error != nil)
        {
            print(error!.localizedDescription)
        }
        
        var err: NSError?
        var jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        if (err != nil)
        {
            print("JSON Error \(err!.localizedDescription)")
        }
        //print(jsonResult)

        

        //let setOne:NSArray = jsonResult["magnitude"] as! NSArray
        //print(jsonResult["item_name"] as! String)
        print(item_name)
        if (jsonResult["item_name"] != nil)
        {
        APIsuccess = true
        item_name = jsonResult["item_name"] as! String
        caloriesAmount = jsonResult["nf_calories"] as! Int
        fatAmount = jsonResult["nf_total_fat"] as! Int
        sodiumAmount = jsonResult["nf_sodium"] as! Int
        sugarAmount = jsonResult["nf_sugars"] as! Int
        }
       else
        {
            item_name = jsonResult["error_message"] as! String
        }
        
        
        
        
       
        
        //dispatch_async(dispatch_get_main_queue()) {item_name = getItemName(jsonResult)}
        dispatch_semaphore_signal(semaphore)
    })
    
    
    jsonQuery.resume()
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    return (UPC, item_name, caloriesAmount, fatAmount, sodiumAmount, sugarAmount)
}

//Check if the API is successfully activated
func getAPISuccess() -> Bool
{
    //print(APIsuccess)
    return APIsuccess
}

func APISuccessToFalse()
{
    APIsuccess = false
}

////////FETCH RECORDS - for core data
func fetchRecords() -> Int
{
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    var x = 0
    fetchResults = ((try? insertContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity])!
    x = fetchResults.count
    //print(x);
    return x;
}


///////ADD TO CORE DATA - add item to core data
func addToCoreData(UPC:Int, item_name:String, caloriesAmount:Int, fatAmount:Int, sodiumAmount:Int, sugarAmount:Int)
{
    
    
    let newItem = NutritionEntity(entity: ent!, insertIntoManagedObjectContext: insertContext)
    
    newItem.upcCode = String(UPC)
    newItem.itemName = item_name
    newItem.caloriesAmount = String(caloriesAmount)
    newItem.fatAmount = String(fatAmount)
    newItem.sodiumAmount = String(sodiumAmount)
    newItem.sugarAmount = String(sugarAmount)
    
    do {
        try insertContext.save()
    } catch let error {
        print("Item could not be added to core data. \(error)")
    }
    
}

func saveCoreData()
{
    do {
        try insertContext.save()
    } catch let error {
        print("Item could not be added to core data. \(error)")
    }
}

//REMOVE SINGLE OBJECT FROM CORE DATA
func RemoveObjectFromCoreData(index:Int)
{

    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            
            let l = fetchResults[index]
            viewContext.deleteObject(l);
            
        }
    }
}

//////DELETE ENTIRE CORE DATA
func DeleteCoreData()
{
    var deleteContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    if #available(iOS 9.0, *) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try deleteContext.executeRequest(deleteRequest)
            try deleteContext.save()
        }
        catch let _ as NSError {
        }
    }
    else {
    }
}


/////GET UPC CODE FROM CORE DATA
func getUPCCode(index: Int) -> String
{
    var UPC:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
    
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            
            let indexResults = fetchResults[index]
            UPC = indexResults.upcCode as String

            return UPC;
        }
    }
    

    
    return (UPC)
}

////GET ITEM NAME
func getItemName(index: Int) -> String
{
    var itemName:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            let indexResults = fetchResults[index]
            itemName = indexResults.itemName as String

            return itemName;
        }
    }
    return (itemName)
}

////GET Calories Amount
func getCaloriesAmount(index: Int) -> String
{
    var caloriesAmount:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            let indexResults = fetchResults[index]
            caloriesAmount = indexResults.caloriesAmount as String

            return caloriesAmount;
        }
    }
    return (caloriesAmount)
}

////GET Fat Amount
func getFatAmount(index: Int) -> String
{
    var fatAmount:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            let indexResults = fetchResults[index]
            fatAmount = indexResults.fatAmount as String

            return fatAmount;
        }
    }
    return (fatAmount)
}

////GET Sodium Amount
func getSodiumAmount(index: Int) -> String
{
    var SodiumAmount:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            let indexResults = fetchResults[index]
            SodiumAmount = indexResults.sodiumAmount as String
            return SodiumAmount;
        }
    }
    return (SodiumAmount)
}

////GET Fat Amount
func getSugarAmount(index: Int) -> String
{
    var sugarAmount:String = ""
    let fetchRequest = NSFetchRequest(entityName: "NutritionEntity")
    
    if  let fetchResults = (try? viewContext.executeFetchRequest(fetchRequest)) as? [NutritionEntity]
    {
        let FetchResultsCount = fetchResults.count
        if FetchResultsCount != 0
        {
            let indexResults = fetchResults[index]
            sugarAmount = indexResults.sugarAmount as String
            return sugarAmount;
        }
    }
    return (sugarAmount)
}


func nearbyMap() //-> (Double)
{
    var address = ""
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address as String, completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?) -> Void in
        if let placemark = placemarks?[0]
        {
            
            var selectedLong = Double(placemark.location!.coordinate.longitude);
            var  selectedLat = Double(placemark.location!.coordinate.latitude);
            var  Latitude = String(selectedLat);
            var Longitude = String(selectedLong);
            var center = CLLocationCoordinate2D(latitude: selectedLat, longitude: selectedLong)
            var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
 
        }
    })
}


//USE GOOGLE API to get store location
func getStoreLocation(lat:Double, long:Double) -> (Double, Double, String, String)
{
    
    let semaphore = dispatch_semaphore_create(0)
    var storeName = ""
    var storeAddress = ""
    var latReturn = 0.0
    var longReturn = 0.0
    
    let urlAsString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?&key=AIzaSyAlIFI0kr87Whn8Kx7bjx3NolbrFjjg-bw&location=" + String(lat) + "," + String(long) + "&rankby=prominence&keyword=grocery+supermarket"
    print(urlAsString)
    
    
    let url = NSURL(string: urlAsString)!
    let urlSession = NSURLSession.sharedSession()
    
    
    let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
        if (error != nil)
        {
            print(error!.localizedDescription)
        }
        
        var err: NSError?
        var jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        if (err != nil)
        {
            print("JSON Error \(err!.localizedDescription)")
        }
        
        // print(jsonResult)
        
        let setOne:NSArray = jsonResult["results"] as! NSArray
        //print(setOne[0])
        //print(setOne[0].valueForKey("geometry")?.valueForKey("location")?.valueForKey("lat"))
        storeName = String(setOne[0].valueForKey("name")!)
        storeAddress = String(setOne[0].valueForKey("vicinity")!)
        latReturn = Double((setOne[0].valueForKey("geometry")?.valueForKey("location")?.valueForKey("lat"))! as! NSNumber)
        longReturn = Double((setOne[0].valueForKey("geometry")?.valueForKey("location")?.valueForKey("lng"))! as! NSNumber)
        dispatch_semaphore_signal(semaphore)
        
    })
    jsonQuery.resume()
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

    return (latReturn, longReturn, storeName, storeAddress)
    
}







