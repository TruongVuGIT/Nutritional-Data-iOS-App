//
//  WebViewController.swift
//  CSE335_Project
//
//  Created by Truong Vu on 11/15/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var item_name:String = ""
    var UPC:Int = 0
    
    @IBOutlet weak var ActivityView: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WebView.delegate = self
        self.WebView.scrollView.scrollEnabled = true
        self.WebView.scalesPageToFit = true
        loadWebsite();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadWebsite()
    {
        var StringConCat = item_name.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let webpage:String = "https://www.google.com/#q=" + StringConCat
        let url = NSURL(string: webpage)
        let request = NSURLRequest(URL: url!)
        ActivityView.hidesWhenStopped = true
        ActivityView.startAnimating()
        WebView.loadRequest(request)
    }

    
}
