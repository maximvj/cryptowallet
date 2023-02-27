
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
        guard let mainViewController = assemblyBuilder?.createMainModule(router: self),
              let navigationController = navigationController
        else { return }
        
        navigationController.viewControllers = [mainViewController]
        Constants.appDelegate?.changeRootViewController(newRootVC: navigationController)
    }
    
    func descriptionViewController(description: CoinModel?) {
            guard  let description = description,
                   let descript = assemblyBuilder?.createDescriptionModule(
                    router: self,
                    description: description ),
                    let navigationController = navigationController
            else { return }
        
            navigationController.pushViewController(descript, animated: true)
    }
    
    func indicatorViewController(state: Bool) {
        if state {
            Constants.appDelegate?.indicatorWindow?.makeKeyAndVisible()
        } else {
            Constants.appDelegate?.window?.makeKeyAndVisible()
        }
    }
}

extension Router {
    
    enum Constants {
        static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
}
