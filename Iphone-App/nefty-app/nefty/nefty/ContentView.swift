import SwiftUI
import UIKit
import CoreLocation

struct ContentView: View {
    @State var userLocation: CLLocation?
    
    var body: some View {
        VStack {
            if let location = userLocation {
                Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
            } else {
                Text("Fetching location...")
            }
            Button("Refresh Location") {
                self.userLocation = nil
                CLLocationManager().requestLocation()
            }
        }
        .padding()
    }
}


class ViewController: UIViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var contentView: ContentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = ContentView()
        contentView?.userLocation = nil
        self.view = contentView.map { UIHostingController(rootView: $0) }.map { $0.view }
        
        manager.delegate = self
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            contentView?.userLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



