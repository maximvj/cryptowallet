
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        listenViewModel()
        setLayout()
        
    }

    func listenViewModel() {}

    func setLayout() {}

}
