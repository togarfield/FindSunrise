//
//  ViewController.swift
//  FindSunrise
//
//  Created by Muhammad abduh Siregar on 27/08/18.
//  Copyright © 2018 Muhammad abduh Siregar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblHasil: UILabel!
    
    @IBOutlet weak var txtCityName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnFindCity(_ sender: Any) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(txtCityName.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        loadUrl(url: url)
    }
    
    func loadUrl(url:String){
        DispatchQueue.global().async {
            do{
                let appURL = URL(string: url)!
                let data = try Data(contentsOf: appURL)
                let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let query = json["query"] as! [String:Any]
                let result = query["results"] as! [String:Any]
                let channel = result["channel"] as! [String:Any]
                let astronomy = channel["astronomy"] as! [String:Any]
                
                DispatchQueue.main.async {
                    self.lblHasil.text = "Sunrise time is \(astronomy["sunrise"]!)"
                }
            }catch{
                DispatchQueue.main.async {
                    self.lblHasil.text="cannot reach server"
                }
            }
        }
    }
}

