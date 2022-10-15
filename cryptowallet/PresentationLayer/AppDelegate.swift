
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var indicatorWindow: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let indicatorViewController = IndicatorViewController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        
        indicatorWindow = UIWindow(frame: UIScreen.main.bounds)
        indicatorWindow?.rootViewController = indicatorViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        router.initialViewController()
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

