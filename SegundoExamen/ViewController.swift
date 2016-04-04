//
//  ViewController.swift
//  SegundoExamen
//
//  Created by César Alejandro Cardenas Gonzalez on 4/4/16.
//  Copyright © 2016 César Alejandro Cardenas Gonzalez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var Controlador :CLLocationManager!
    
    @IBOutlet weak var LatitudL: UILabel!
    @IBOutlet weak var LongitudL: UILabel!
    @IBOutlet weak var AccuracyL: UILabel!
    @IBOutlet weak var SpeedL: UILabel!
    @IBOutlet weak var AltitudeL: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Controlador = CLLocationManager()
        Controlador.delegate = self
        Controlador.desiredAccuracy = kCLLocationAccuracyBest
        Controlador.requestWhenInUseAuthorization()
        Controlador.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        self.LatitudL.text = "\(userLocation.coordinate.latitude)"
        
        self.LongitudL.text = "\(userLocation.coordinate.longitude)"
        
        self.SpeedL.text = "\(userLocation.speed)"
        
        self.AltitudeL.text = "\(userLocation.altitude)"
        
        self.AccuracyL.text = "\(userLocation.verticalAccuracy)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            }
            else {
                
                // finding info about location
                if let p = placemarks?[0] {
                    
                    var fullAddress = ""
                    
                    // checking if the infirmation exist to add it to the label
                    if let street = p.thoroughfare {
                        
                        fullAddress.appendContentsOf(street)
                        
                    }
                    
                    if let sublocal = p.subLocality {
                        
                        fullAddress.appendContentsOf("\n\(sublocal)")
                       // direction = sublocal
                        
                    }
                    
                    if let adminArea = p.administrativeArea {
                        
                        fullAddress.appendContentsOf("\n\(adminArea)")
                        
                    }
                    
                    if let postCode = p.postalCode {
                        
                        fullAddress.appendContentsOf("\n\(postCode)")
                        
                    }
                    
                    if let country = p.country {
                        
                        fullAddress.appendContentsOf("\n\(country)")
                    }
                    
                    //print(fullAddress)
                    self.Result.text = fullAddress
                    
                }
                
                
            }
            
        })
        }


}
