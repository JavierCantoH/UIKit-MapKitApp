//
//  ViewController.swift
//  MapExample
//
//  Created by Luis Javier Canto Hurtado on 19/05/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var textFieldAdress: UITextField!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        if(manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization))) {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func getDirectionstapped(_ sender: Any) {
        getAdress()
    }
    
    func getAdress(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFieldAdress.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else{
                print("No LocationFound")
                return
            }
            print(location)
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D){
        let souceCordinate = (manager.location?.coordinate)!
        
        let soucePlacMark = MKPlacemark(coordinate: souceCordinate)
        let destPlacMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceitem = MKMapItem(placemark: soucePlacMark)
        let destItem = MKMapItem(placemark: destPlacMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceitem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else{
                if let error = error {
                    print("Something is wrong")
                    print(error)
                }
                return
            }
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion.init(center: userLocation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        map.setRegion(map.regionThatFits(region), animated: true)
        let point = MKPointAnnotation()
        point.coordinate = userLocation.coordinate
        point.title = "Can you see me?"
        point.subtitle = "Right here!"
        map.addAnnotation(point)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}

