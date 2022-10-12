
import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coinTableView = UITableView()
    var coinModelArray = [CoinModel]()
    var mainViewModel: (MainModuleProtocolIn & MainModuleProtocolOut)?
    
    // MARK:  - Ovveride Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setTableView()
        mainViewModel?.getData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func listenViewModel() {
        guard var mainViewModel = mainViewModel else {
            return
        }
        
        mainViewModel.sendData = { [weak self] result in
            self?.coinModelArray = result
            DispatchQueue.main.async {
                self?.coinTableView.reloadData()
            }
        }
    }
    
    override func setLayout() {
        view.addSubview(coinTableView)
        coinTableView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    // MARK: - Methods
    
    func setTableView () {
        coinTableView.delegate = self
        coinTableView.dataSource = self
        coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "CoinCell")
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
