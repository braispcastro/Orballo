//
//  SettingsViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenterProtocol!
    private var viewModel: Settings.ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
    }

}

extension SettingsViewController: SettingsViewControllerProtocol {
    
    func show(viewModel: Settings.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
    }
    
}
