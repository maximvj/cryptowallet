
import Foundation

protocol NetworkServiceProtocol {
    func fetchCoinInfo (completionHandler: @escaping (([CoinModel]) -> Void))
}

final class NetworkService: NetworkServiceProtocol {
    var coinNames = ["btc", "eth", "tron", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    func fetchCoinInfo(completionHandler: @escaping (([CoinModel]) -> Void)) {
        let group = DispatchGroup()
        var coinModelArray =  [CoinModel]()
        
        for coinName in coinNames {
            group.enter()
            let urlString = "https://data.messari.io/api/v1/assets/\(coinName)/metrics"
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {return}
                
                if let coinModel = self.parseJSON(withData: data) {
                    coinModelArray.append(coinModel)
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
            print("error: ", error)
        }
        return nil
    }
}
