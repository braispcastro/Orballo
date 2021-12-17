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
        self.view.backgroundColor = UIColor(named: "OrballoBackground")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "OrballoTextLight")!]
        self.tabBarController?.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.tabBarController?.navigationController?.navigationBar.sizeToFit()
    }
    
    func provideHapticFeedback(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedback = UIImpactFeedbackGenerator(style: feedbackStyle)
        feedback.impactOccurred()
    }
}
