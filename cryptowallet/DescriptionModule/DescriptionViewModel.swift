
import Foundation

// In ViewModel
protocol DescriptionModuleProtocolIn {
    init (router: RouterProtocol, description: CoinModel)
    func getDescription()
}

// From ViewModel
protocol DescriptionModuleProtocolOut {
    var sendData: (CoinModel) -> () { get set }
}

class DescriptionViewModel: DescriptionModuleProtocolIn, DescriptionModuleProtocolOut  {
    var router: RouterProtocol?
    var description: CoinModel?
    var sendData: (CoinModel) -> () = {_ in }
    
    required init(router: RouterProtocol, description: CoinModel) {
        self.router = router
        self.description = description
    }
    
    func getDescription() {
        if let unwrapDescription = description {
            sendData(unwrapDescription)
        }
    }
}
