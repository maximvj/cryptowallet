
import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func loginViewController() -> UIViewController
    func mainViewController()
}


class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func loginViewController() -> UIViewController {
    guard let loginViewController = assemblyBuilder?.createLoginModule(router: self) else { return UIViewController() }
           return loginViewController
    }
    
    func mainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(newRootVC: navigationController)
        }
    }
}

