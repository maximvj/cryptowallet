
import Foundation

protocol NetworkServiceProtocol {
    func fetchCoinInfo (completionHandler: @escaping (([CoinModel]) -> Void))
}

final class NetworkService: NetworkServiceProtocol {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    
    func fetchCoinInfo(completionHandler: @escaping (([CoinModel]) -> Void)) {
        let group = DispatchGroup()
        let coinNames = Coins.allCases.map { $0.rawValue }
        var coinModelArray =  [CoinModel]()
        var urlString = ""
        
        for coinName in coinNames {
            group.enter()
            urlString = "https://data.messari.io/api/v1/assets/\(coinName)/metrics"
            guard let url = URL(string: urlString) else {return}
            
            URLSession.shared.dataTask(with: url) { result in
                switch result {
                case .success(let data):
                    if let coinModel = self.parseJSON(withData: data) {
                        coinModelArray.append(coinModel)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                group.leave()
            }
            .resume()
        }
        
        group.notify(queue: .main) {
            let sortedArray = coinModelArray.sorted(by: {$0.percentChangeUSDperDay ?? 0 > $1.percentChangeUSDperDay ?? 0})
            completionHandler(sortedArray)
        }
    }
    
    func parseJSON(withData data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let networkData = try decoder.decode(CoinModelData.self, from: data)
            guard let coinModel = CoinModel(coinModelData: networkData) else {
                return nil
            }
            
            return coinModel
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension NetworkService {
    
    enum Coins: String, CaseIterable {
        case btc
        case tron
        case polkadot
        case dogecoin
        case tether
        case stellar
        case cardano
        case xrp
    }
    
}
