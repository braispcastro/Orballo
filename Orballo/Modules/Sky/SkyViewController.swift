//
//  SkyViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import UIKit

class SkyViewController: BaseViewController {

    var presenter: SkyPresenterProtocol!
    private var viewModel: Sky.ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.prepareView()
        super.viewWillAppear(animated)
    }

}

extension SkyViewController: SkyViewControllerProtocol {
    
    func show(viewModel: Sky.ViewModel) {
        self.viewModel = viewModel
        self.tabBarController?.title = viewModel.title
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
