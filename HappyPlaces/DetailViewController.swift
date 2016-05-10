//
//  DetailViewController.swift
//  HappyPlaces
//
//  Created by Roman on 5/8/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate
{
    var aPlace: HappyPlace?
    var locationMgr: CLLocationManager!

    var searchAnnonation: MKAnnotation!

    var newLocationDelegate: NewLocationDelegate?

    var _masterTableViewController: NewLocationDelegate?
    {
        get
        {
            let navController = self.splitViewController?.viewControllers[0] as! UINavigationController
            let master = navController.viewControllers[0] as! MasterTableViewController
            return master
        }
    }


    @IBOutlet weak var mapOutlet: MKMapView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationMgr = CLLocationManager()
        locationMgr.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        newLocationDelegate = _masterTableViewController

        if aPlace != nil
        {
            let lat = aPlace?.lat
            let long = aPlace?.long
            let location = CLLocationCoordinate2DMake(lat!, long!)

            let span = MKCoordinateSpanMake(0.05, 0.05)

            let region = MKCoordinateRegionMake(location, span)

            self.mapOutlet.setRegion(region, animated: true)

            let annonation = MKPointAnnotation()
            annonation.title = aPlace?.name
            annonation.coordinate = location
            self.mapOutlet.addAnnotation(annonation)

            self.title = aPlace?.name
        }

        let pinGesture = UILongPressGestureRecognizer(target: self, action: "newLocation:")
        pinGesture.minimumPressDuration = 1.5
        self.mapOutlet.addGestureRecognizer(pinGesture)
    }

    func newLocation(gestureRecognizer: UIGestureRecognizer)
    {
        if gestureRecognizer.state == UIGestureRecognizerState.Began
        {
            let touched = gestureRecognizer.locationInView(self.mapOutlet)
            let touchCoordinates = mapOutlet.convertPoint(touched, toCoordinateFromView: self.mapOutlet)
            let location = CLLocation(latitude: touchCoordinates.latitude, longitude: touchCoordinates.longitude)

            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
                (placemarks, error) -> Void in
                var title = ""
                if error == nil
                {
                    if let validPlacemark = placemarks?[0]
                    {
                        let placemark = validPlacemark as? CLPlacemark

                        var street = ""
                        var city = ""

                        if placemark!.thoroughfare != nil
                        {
                            street = placemark!.thoroughfare!
                        }

                        if placemark!.subAdministrativeArea != nil
                        {
                            city = placemark!.subAdministrativeArea!
                        }
                        title = "\(street), \(city)"
                    }
                }

                let delegate = self.newLocationDelegate!
                delegate.newLocationAdded(title, lat: touchCoordinates.latitude, long: touchCoordinates.longitude)

                let annotaion = MKPointAnnotation()
                annotaion.coordinate = touchCoordinates
                annotaion.title = title
                self.mapOutlet.addAnnotation(annotaion)
            })
            
        }
    }
}