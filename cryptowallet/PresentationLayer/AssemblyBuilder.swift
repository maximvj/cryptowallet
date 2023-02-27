
import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDescriptionModule(router: RouterProtocol, description: CoinModel) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let viewModel = LoginViewModel(router: router)
        view.loginViewModel = viewModel
        return view
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let network = NetworkService()
        let viewModel = MainViewModel(router: router, network: network)
        view.mainViewModel = viewModel
        return view
    }
    
    func createDescriptionModule(router: RouterProtocol, description: CoinModel) -> UIViewController {
        let view = DescriptionViewController()
        let viewModel = DescriptionViewModel(router: router, description: description)
        view.viewModel = viewModel
        return view
    }
    
}
