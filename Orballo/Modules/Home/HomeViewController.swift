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
    private var locationList: [Home.LocationViewModel] = []
    
    enum ReuseIdentifiers {
        static let locationCell = "location-cell"
        static let addLocationCell = "add-location-cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        let locationCell = UINib(nibName: "LocationTableViewCell", bundle: nil)
        let addLocationCell = UINib(nibName: "AddLocationTableViewCell", bundle: nil)
        locationTableView.register(locationCell, forCellReuseIdentifier: ReuseIdentifiers.locationCell)
        locationTableView.register(addLocationCell, forCellReuseIdentifier: ReuseIdentifiers.addLocationCell)
    }
    	
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
        presenter.getLocationsToShow()
        super.viewWillAppear(animated)
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    
    func show(viewModel: Home.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func showLocations(locations: [Home.LocationViewModel]) {
        locationList = locations
        locationTableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < locationList.count {
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
        let item = locationList[indexPath.section]
        
        guard let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.locationCell) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.locationName.text = item.name
        cell.locationImage.isHidden = !item.isCurrentLocation
        cell.weatherDescription.text = item.weatherDescription
        cell.temperature.text = item.temperature
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationList[indexPath.section]
            presenter.locationToDelete(locationViewModel: location)
            locationList.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0 && indexPath.section != locationList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
