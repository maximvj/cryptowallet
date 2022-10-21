
import UIKit
import SnapKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: (DescriptionModuleProtocolIn & DescriptionModuleProtocolOut)?
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    private var priceLabel = UILabel()
    private var dayChangeLabel = UILabel()
    private var roiWeekLabel = UILabel()
    private var roiMonthLabel = UILabel()
    private var roiYearLabel = UILabel()
    
    private var descriptionStackView = UIStackView()
    
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
    
    private func setStackView() {
        descriptionStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, dayChangeLabel, roiWeekLabel, roiMonthLabel, roiYearLabel ])
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 20
        descriptionStackView.distribution = .fillEqually
    }
    
    private func setLayout() {
        view.addSubview(descriptionStackView)
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-300)
        }
    }
    
    private func listenViewModel() {
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
