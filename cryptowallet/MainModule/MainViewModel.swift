
import Foundation

// In ViewModel
protocol MainModuleProtocolIn {
    init (router: RouterProtocol, network: NetworkServiceProtocol)
    func getData()
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

    
}
