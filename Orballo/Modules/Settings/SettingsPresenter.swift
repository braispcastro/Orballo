//
//  SettingsPresenter.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation

protocol SettingsViewControllerProtocol {
    func show(viewModel: Settings.ViewModel)
}

protocol SettingsPresenterProtocol {
    func prepareView()
}

final class SettingsPresenter {

    let interactor: SettingsInteractorProtocol
    let viewController: SettingsViewControllerProtocol
    let router: SettingsRouterProtocol
    
    init(viewController: SettingsViewControllerProtocol,
         router: SettingsRouterProtocol,
         interactor: SettingsInteractorProtocol) {
            self.viewController = viewController
            self.router = router
            self.interactor = interactor
        }
    
    
    private func getStringVersion() -> String {
        var appVersion = "."
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }
        return appVersion
    }
    
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func prepareView() {
        let viewModel = Settings.ViewModel(title: "Settings", version: getStringVersion())
        viewController.show(viewModel: viewModel)
    }
    
}

extension SettingsPresenter: SettingsInteractorCallbackProtocol {
    
}
