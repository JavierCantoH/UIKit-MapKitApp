# UIKit-MapKitApp 🗺️

Welcome to the UIKit-MapKitApp repository! This repository contains a simple iOS app that demonstrates how to use MapKit to display a map and drop a pin on a location. 📱📍

## Overview 📝

The UIKit-MapKitApp is a straightforward iOS app that allows users to view a map and drop a pin on a location. The app includes a variety of features to help users explore the map, including the ability to zoom in and out, and to view the map in different modes, such as standard, satellite, and hybrid. 🌍🔍

The project includes the following features:

- A simple and intuitive interface that is easy to use and navigate 📱👀
- Integration with MapKit to display a map and drop a pin on a location 🗺️📍
- The ability to zoom in and out of the map and switch between different map modes 🌍🛰️

## Getting Started 🚀

To get started with the UIKit-MapKitApp, simply clone this repository and open the Xcode project file. You can then build and run the app in the iOS Simulator or on a physical iOS device. 🛠️📱

## Usage 🤖

To use the UIKit-MapKitApp in your own iOS app, simply copy the necessary files and APIs to your project and modify the code to fit your needs. The project is designed to be modular and customizable, so you can easily add or remove features as needed. 📝🎨

```swift
import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Set up the map view
    mapView.delegate = self
    mapView.showsUserLocation = true
    // Add a pin to the map
    let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    mapView.addAnnotation(annotation)
    // Zoom the map to the pin
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(region, animated: true)
  }

}

extension ViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // Configure the pin view
    let identifier = "PinView"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    } else {
      annotationView?.annotation = annotation
    }
    return annotationView
  }

}
```

Credits 🙌

The UIKit-MapKitApp was created by Javier Canto as a simple example of how to use MapKit in an iOS app.
