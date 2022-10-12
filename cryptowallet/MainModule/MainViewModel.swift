
import Foundation

// In ViewModel
protocol MainModuleProtocolIn {
    init (router: RouterProtocol, network: NetworkServiceProtocol)
    func getData()
    func handleTapCell(description: CoinModel)
}

// From ViewModel
protocol MainModuleProtocolOut {
    var sendData: ([CoinModel]) -> () { get set }
}


class MainViewModel: MainModuleProtocolIn, MainModuleProtocolOut {
    
    let networkService: NetworkServiceProtocol?
    let router: RouterProtocol?
    var sendData: ([CoinModel]) -> () = {_ in }
    
    required init(router: RouterProtocol, network: NetworkServiceProtocol) {
        self.networkService = network
        self.router = router
    }
    
    func getData() {
        self.networkService?.fetchCoinInfo(completionHandler: { [weak self] coinModelArray in
            self?.sendData(coinModelArray)
        })
    }
    
    func handleTapCell(description: CoinModel) {
        router?.descriptionViewContoller(description: description)
    }
}
