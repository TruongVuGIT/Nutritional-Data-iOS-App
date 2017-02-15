//
//  MapsViewController.swift
//  CSE335_Project
//
//  Created by Truong Vu on 10/17/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    //Get closest store address
    @IBAction func searchbtn(sender: AnyObject) {
        
        var lat:Double = 0.0
        var long:Double = 0.0
        var storeName = ""
        var address = addressInput.text
        var storeAddress = ""
    
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address! as String, completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            if let placemark = placemarks?[0]
            {
                
                long = Double(placemark.location!.coordinate.longitude);
                lat = Double(placemark.location!.coordinate.latitude);
                
                
               
                
                (lat, long, storeName, storeAddress) = getStoreLocation(lat, long: long)
             
                
                let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = center
                annotation.title = storeName
                annotation.subtitle = storeAddress
                self.MapView.addAnnotation(annotation)
                self.MapView.setRegion(region, animated: true)
            }
        })
        
    }
    
}




