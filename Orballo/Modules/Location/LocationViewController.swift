//
//  LocationViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import UIKit
import MapKit

class LocationViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var centerLocationButton: UIButton!
    @IBOutlet weak var addLocationButton: UIButton!
    
    var presenter: LocationPresenterProtocol!
    private var viewModel: Location.ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        centerLocationButton.addTarget(self, action: #selector(centerInCurrentLocation), for: .touchUpInside)
        addLocationButton.addTarget(self, action: #selector(getLocationInformation), for: .touchUpInside)
        
        presenter.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = ""
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    @objc private func centerInCurrentLocation() {
        let center = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
    }
    
    @objc private func getLocationInformation() {
        let lat = mapView.centerCoordinate.latitude
        let lon = mapView.centerCoordinate.longitude
        presenter.getLocationInformation(latitude: lat, longitude: lon)
    }

}

extension LocationViewController: LocationViewControllerProtocol {
    
    func show(viewModel: Location.ViewModel) {
        self.viewModel = viewModel
        centerInCurrentLocation()
    }
    
    func askForConfirmationToAddLocation(placeViewModel: Location.PlaceViewModel) {
        let msg = "Do you want to add '\(placeViewModel.city)' to your location list?"
        let dialog = UIAlertController(title: "Add location", message: msg, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        dialog.addAction(UIAlertAction(title: "Accept", style: .default) { action in
            self.presenter.saveLocation(placeViewModel: placeViewModel)
        })
        present(dialog, animated: true, completion: nil)
    }
    
}
