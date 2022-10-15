
import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func rootLoginViewController()
    func rootMainViewController()
    func descriptionViewController(description: CoinModel?)
    func indicatorViewController(state: Bool)
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if UserDefaults.standard.isLoggedIn() {
            self.rootMainViewController()
        } else {
            self.rootLoginViewController()
        }
    }
    
    func rootLoginViewController() {
    guard let loginViewController = assemblyBuilder?.createLoginModule(router: self) else { return }
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(newRootVC: loginViewController)
    }
    
    func rootMainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(newRootVC: navigationController)
        }
    }
    
    func descriptionViewController(description: CoinModel?) {
        if let navigationController = navigationController, let description = description {
            guard let descriptionViewController = assemblyBuilder?.createDescriptionModule(router: self, description: description) else { return }
            navigationController.pushViewController(descriptionViewController, animated: true)
        }
    }
    
    func indicatorViewController(state: Bool) {
        if state {
            (UIApplication.shared.delegate as? AppDelegate)?.indicatorWindow?.makeKeyAndVisible()
        } else {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
        }
    }
    
}

