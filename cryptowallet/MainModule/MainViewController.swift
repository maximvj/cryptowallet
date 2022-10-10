
import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coinTableView = UITableView()
    var mainViewModel: (MainModuleProtocolIn & MainModuleProtocolOut)?
    
    // MARK:  - Ovveride Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemMint
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
            for i in result {
                print(i.name)
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
        coinTableView.backgroundColor = .systemMint
        coinTableView.delegate = self
        coinTableView.dataSource = self
        coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "CoinCell")
    }
  

}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = coinTableView.dequeueReusableCell(withIdentifier: "CoinCell") as? CoinTableViewCell {
            cell.backgroundColor = .yellow
           return cell
        }
        return UITableViewCell()
    }
    
    
}
