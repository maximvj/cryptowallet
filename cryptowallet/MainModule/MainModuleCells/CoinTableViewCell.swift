
import UIKit
import SnapKit

class CoinTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    var priceLabel = UILabel()
    var dayChangeLabel = UILabel()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var cellStackView = UIStackView()
    
    var cellCoinModel: CoinModel? {
        didSet {
            nameLabel.text = cellCoinModel?.name
            priceLabel.text = cellCoinModel?.priceUsdString
            dayChangeLabel.text = cellCoinModel?.dayChangeInUSDString            
        }
    }
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setLayout() {
        contentView.addSubview(cellStackView)
        cellStackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(20)
        }
    }
    
    func setStackView() {
        cellStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, dayChangeLabel])
        cellStackView.axis = .vertical
        cellStackView.alignment = .fill
        cellStackView.distribution = .fill
    }
}
