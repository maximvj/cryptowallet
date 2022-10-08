
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.loginViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func changeRootViewController(newRootVC: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = newRootVC
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}

