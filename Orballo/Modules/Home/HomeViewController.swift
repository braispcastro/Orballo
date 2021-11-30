//
//  HomeViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var locationTableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    private var viewModel: Home.ViewModel!
    private var locations: [Home.LocationViewModel] = []
    
    enum ReuseIdentifiers {
        static let locationCell = "location-cell"
        static let addLocationCell = "add-location-cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        let locationCell = UINib(nibName: "LocationTableViewCell", bundle: nil)
        let addLocationCell = UINib(nibName: "AddLocationTableViewCell", bundle: nil)
        locationTableView.register(locationCell, forCellReuseIdentifier: ReuseIdentifiers.locationCell)
        locationTableView.register(addLocationCell, forCellReuseIdentifier: ReuseIdentifiers.addLocationCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    
    func show(viewModel: Home.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
        
        // Mocked locations
        locations = [
            Home.LocationViewModel(name: "A Coruña", isCurrentLocation: true, weatherDescription: "Parcialmente nublado", temperature: "12º"),
            Home.LocationViewModel(name: "A Coruña", isCurrentLocation: false, weatherDescription: "Parcialmente nublado", temperature: "12º"),
            Home.LocationViewModel(name: "A Veiga", isCurrentLocation: false, weatherDescription: "Despejado", temperature: "2º")
        ]
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return locations.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < locations.count {
            return 130
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < locations.count {
            let item = locations[indexPath.section]
            
            guard let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.locationCell) as? LocationTableViewCell else {
                return UITableViewCell()
            }
            
            cell.locationName.text = item.name
            cell.locationImage.isHidden = !item.isCurrentLocation
            cell.weatherDescription.text = item.weatherDescription
            cell.temperature.text = item.temperature
            return cell
        } else {
            guard let cell: AddLocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.addLocationCell) as? AddLocationTableViewCell else {
                return UITableViewCell()
            }
            
            cell.title.text = "NEW LOCATION"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
