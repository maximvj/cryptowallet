
import Foundation

// MARK: - Protocols

// In ViewModel
protocol DescriptionModuleProtocolIn {
    init (router: RouterProtocol, description: CoinModel)
    func getDescription()
}

// From ViewModel
protocol DescriptionModuleProtocolOut {
    var sendData: (CoinModel) -> () { get set }
}

// MARK: - Classes

class DescriptionViewModel: DescriptionModuleProtocolIn, DescriptionModuleProtocolOut {
    var sendData: (CoinModel) -> () = {_ in }
    
    private var router: RouterProtocol?
    private var description: CoinModel?
    
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
