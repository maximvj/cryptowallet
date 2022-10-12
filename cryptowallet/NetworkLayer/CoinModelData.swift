
import Foundation



// MARK: - DataClass

struct CoinModelData: Codable {
    let data: DataClass?
}

struct DataClass: Codable {
    let name: String
    let marketData: MarketData
    let roiData: [String:Double]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case roiData = "roi_data"
        case marketData = "market_data"
    }
    
}


// MARK: - MarketData

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeUSDperDay: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUSDperDay = "percent_change_usd_last_24_hours"
    }
}
