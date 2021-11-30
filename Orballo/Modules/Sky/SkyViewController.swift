//
//  SkyViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import UIKit

class SkyViewController: UIViewController {

    var presenter: SkyPresenterProtocol!
    private var viewModel: Sky.ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
    }

}

extension SkyViewController: SkyViewControllerProtocol {
    
    func show(viewModel: Sky.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
    }
    
}
