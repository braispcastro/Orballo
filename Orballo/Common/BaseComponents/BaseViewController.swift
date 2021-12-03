//
//  BaseViewController.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.tabBarController?.navigationController?.navigationBar.sizeToFit()
    }

}
