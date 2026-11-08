//
//  PlacesMapViewController.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit
import MapKit

class PlacesMapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    var places: [Place] = []
    var pins: [MKPointAnnotation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Theme.styleNavigationBar(of: self)
        mapView.delegate = self

        places = PortfolioDataService.shared.data?.places ?? []
        addPins()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showAnnotations(pins, animated: true)
    }

    func addPins() {
        for place in places {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            pin.title = place.name
            pin.subtitle = place.country
            pins.append(pin)
        }
        mapView.addAnnotations(pins)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "PlacePin"
        let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView.annotation = annotation
        pinView.markerTintColor = Theme.black
        pinView.glyphImage = UIImage(systemName: "star.fill")
        pinView.canShowCallout = true
        return pinView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1). \(place.name)"
        cell.detailTextLabel?.text = "\(place.country) · \(place.description)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pin = pins[indexPath.row]
        let region = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 80_000, longitudinalMeters: 80_000)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(pin, animated: true)
    }
}
