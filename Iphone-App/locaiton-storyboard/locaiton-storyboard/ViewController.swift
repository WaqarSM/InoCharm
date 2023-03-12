//
//  ViewController.swift
//  locaiton-storyboard
//
//  Created by Waqar Muhammad on 2023-03-08.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    private var count = 0
    var currentLocation: CLLocation?
    
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var ContactNameField: UITextField!
//    let contactName = ContactNameField.text ?? ""
    var contactName: String = ""
    @IBOutlet var messageField: UITextField!
    
   
    
    var manager: CLLocationManager =  CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "Ready! \n \(count)"
        UIDevice.current.isBatteryMonitoringEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if UIDevice.current.isBatteryMonitoringEnabled {
                print("Battery monitoring is enabled")
            } else {
                print("Battery monitoring is not enabled")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else{
            return
        }
        // Update the currentLocation property
        self.currentLocation = first
        label.text = ("Latitude: \(first.coordinate.latitude)\nLongitude: \(first.coordinate.longitude)\n\nCount: \(count)")
    }
    
    @IBAction func countUp(_ sender: Any) {
        count += 1
        //This will fun if button is pressed!!
        let contactName = ContactNameField.text ?? ""
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let batteryStatus = "\(batteryLevel)%"
        print(batteryLevel)
        
        guard let location = currentLocation else {
            print("Location not available yet.")
            return
        }
        let locationString = "Lat: \(location.coordinate.latitude),\n Lon: \(location.coordinate.longitude)\n\n https://www.google.com/maps?q=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        sendSMSUsingTwilio(toRecipient: "+16478855292", message: "‼️\n\n\(contactName), I have activated my neft-e.\n\n My current location is Location:\n \(locationString)\n\n My phone's current battery level is:\(batteryStatus)")
        print("‼️\n\n\(contactName), I have activated my neft-e.\n\n My current location is Location:\n \(locationString)\n\n My phone's current battery level is:\(batteryStatus)")
    }
    
    func sendSMSUsingTwilio(toRecipient: String, message: String) {
        let accountSid = "ACdb6dbe1f26c50e6777281b4b76c1a65c"
        let authToken = "417454a080526b82c9e80889ca74e5c3"
        let fromPhoneNumber = "+13855267387" //my twillio number - given by twillio
        let toPhoneNumber = toRecipient //"+16478855292"
        let messageBody = message
        
        let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/\(accountSid)/Messages.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "From=\(fromPhoneNumber)&To=\(toPhoneNumber)&Body=\(messageBody)"
        let bodyData = body.data(using: .utf8)
        
        request.httpBody = bodyData
        
        let authString = "\(accountSid):\(authToken)"
        let authData = authString.data(using: String.Encoding.utf8)!
        let base64AuthString = authData.base64EncodedString()
        
        request.setValue("Basic \(base64AuthString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            // Handle data
            print("Response data: \(String(data: data, encoding: .utf8) ?? "Empty data")")
        }
        task.resume()
    }
}

