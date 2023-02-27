
import UIKit
import SnapKit

class IndicatorViewController: UIViewController {
    
    private let spiner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color =  .systemTeal
        view.style = .large
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        spiner.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        spiner.stopAnimating()
    }
    
    private func setLayout() {
        view.addSubview(spiner)
        spiner.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        
    }
}
