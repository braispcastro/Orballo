//
//  LocationViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import UIKit

class LocationViewController: UIViewController {

    var presenter: LocationPresenterProtocol!
    private var viewModel: Location.ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
    }

}

extension LocationViewController: LocationViewControllerProtocol {
    
    func show(viewModel: Location.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
    }
    
}
