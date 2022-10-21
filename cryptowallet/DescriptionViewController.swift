
import UIKit
import SnapKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    var priceLabel = UILabel()
    var dayChangeLabel = UILabel()
    var roiWeekLabel = UILabel()
    var roiMonthLabel = UILabel()
    var roiYearLabel = UILabel()
    
    var viewModel: (DescriptionModuleProtocolIn & DescriptionModuleProtocolOut)?
    
    var descriptionStackView = UIStackView()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        
        listenViewModel()
        viewModel?.getDescription()
        setStackView()
        setLayout()
    }
    
    // MARK: - Methods
    
    func setStackView() {
        descriptionStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, dayChangeLabel, roiWeekLabel, roiMonthLabel, roiYearLabel ])
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 20
        descriptionStackView.distribution = .fillEqually
    }
    
    func setLayout() {
        view.addSubview(descriptionStackView)
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-300)
        }
    }
    
    func listenViewModel() {
        viewModel?.sendData = { [weak self] description in
            self?.nameLabel.text = description.name
            self?.priceLabel.text = description.priceUsdString
            self?.dayChangeLabel.text = description.dayChangeInUSDString
            self?.roiWeekLabel.text = description.roiLast1Week
            self?.roiMonthLabel.text = description.roiLast1Month
            self?.roiYearLabel.text = description.roiLast1Year
        }
    }
    
}