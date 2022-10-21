
import Foundation

// MARK: - Protocols

// In ViewModel
protocol MainModuleProtocolIn{
    init (router: RouterProtocol, network: NetworkServiceProtocol)
    func getData()
    func handleTapCell(description: CoinModel)
    func logOut()
    func showActivityIndicator(state: Bool)
}

// From ViewModel
protocol MainModuleProtocolOut: AnyObject {
    var sendData: ([CoinModel]) -> () { get set }
    func getSortedData(state: TapState) -> [CoinModel]
}

// MARK: - Classes

class MainViewModel: MainModuleProtocolIn, MainModuleProtocolOut {
    
    // MARK: - Properties
    
    var sendData: ([CoinModel]) -> () = {_ in }
    
    private let networkService: NetworkServiceProtocol?
    private let router: RouterProtocol?
    private var coinModelArray = [CoinModel]()
    
   // MARK: - Inits
    
    required init(router: RouterProtocol, network: NetworkServiceProtocol) {
        self.networkService = network
        self.router = router
    }
    
    // MARK: - Methods
    
    func getData() {
        self.networkService?.fetchCoinInfo(completionHandler: { [weak self] coinModelArray in
            self?.coinModelArray = coinModelArray
            self?.sendData(coinModelArray)
        })
    }
    
    func getSortedData(state: TapState) -> [CoinModel] {
        switch state {
        case .stateOne:
            let model = coinModelArray.sorted(by: {$0.percentChangeUSDperDay ?? 0 < $1.percentChangeUSDperDay ?? 0})
            return model
        case .stateTwo:
            let model = coinModelArray.sorted(by: {$0.percentChangeUSDperDay ?? 0 > $1.percentChangeUSDperDay ?? 0})
            return model
        }
    }
    
    func handleTapCell(description: CoinModel) {
        router?.descriptionViewController(description: description)
    }
    
    func logOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        router?.rootLoginViewController()
    }
    
    func showActivityIndicator(state: Bool) {
        router?.indicatorViewController(state: state)
    }
}
