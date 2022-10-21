
import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var mainViewModel: (MainModuleProtocolIn & MainModuleProtocolOut)?
    
    private var sortButton = CustomButton()
    private var refreshButton = CustomButton()
    private var logOutButton = CustomButton()
    private var stackView = UIStackView()
    private var coinTableView = UITableView()
    private var coinModelArray = [CoinModel]()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .white
        
        listenViewModel()
        mainViewModel?.getData()
        mainViewModel?.showActivityIndicator(state: true)
        setTableView()
        setStackView()
        setButtons()
        setLayout()
    }
    
    // MARK: - Methods
    
    private func listenViewModel() {
        guard let mainViewModel = mainViewModel else {
            return
        }
        mainViewModel.sendData = { [weak self, weak mainViewModel] result in
            self?.coinModelArray = result
            DispatchQueue.main.async {
                self?.coinTableView.reloadData()
            }
            mainViewModel?.showActivityIndicator(state: false)
        }
    }
    
    private func setTableView () {
        coinTableView.delegate = self
        coinTableView.dataSource = self
        coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "CoinCell")
    }
    
    private func setButtons () {
        logOutButton.setTitle("Logout", for: .normal)
        refreshButton.setTitle("Refresh", for: .normal)
        sortButton.setTitle("Change(1 day) ↓", for: .normal)
        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(sortByChange), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        
    }
    
    private func setStackView() {
        stackView = UIStackView(arrangedSubviews: [logOutButton, sortButton, refreshButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
    }
    
    private func setLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        view.addSubview(coinTableView)
        coinTableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).inset(-20)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    // MARK: - Objc methods
    
    @objc private func refreshData () {
        mainViewModel?.showActivityIndicator(state: true)
        mainViewModel?.getData()
        sortButton.setTitle("Change(1 day) ↓", for: .normal)
    }
    
    @objc private func sortByChange() {
        if let tapState = sortButton.tapState, let coinArray = mainViewModel?.getSortedData(state: tapState) {
            coinModelArray = coinArray
            
            DispatchQueue.main.async {
                self.coinTableView.reloadData()
            }
            
            switch tapState {
            case .stateOne : sortButton.setTitle("Change(1 day) ↑", for: .normal)
            case .stateTwo : sortButton.setTitle("Change(1 day) ↓", for: .normal)
            }
        }
        sortButton.switchTapState()
    }
    
    @objc private func logOut () {
        
        mainViewModel?.logOut()
    }
}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = coinTableView.dequeueReusableCell(withIdentifier: "CoinCell") as? CoinTableViewCell {
            cell.cellCoinModel = coinModelArray[safe: indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let coinModel = coinModelArray[safe: indexPath.row] else { return }
        mainViewModel?.handleTapCell(description: coinModel)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
