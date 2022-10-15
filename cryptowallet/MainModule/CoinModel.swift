
import Foundation

struct CoinModel {
    let name: String
    let percentChangeUSDperDay: Double?
    private let priceUSD: Double?
    private let roiData: [String: Double]
    
    var priceUsdString : String {
        if let priceUSD = priceUSD {
            return "🇺🇸 USD: " + String(format: "%.6f", priceUSD) + " $"
        }
        return "🇺🇸 USD: " + " ... " + " $"
    }
    
    var dayChangeInUSDString: String {
        if let percentChangeUSDperDay = percentChangeUSDperDay {
            return "Change per day: " + String(format: "%.6f", percentChangeUSDperDay) + " %"
        }
        return "Change per day: " + " ... " + " $"
    }
    
    var roiLast1Week: String {
        if let roiData1Week = roiData["percentChangeLast1Week"] {
            return "ROI(last week): " + String(format: "%.6f", roiData1Week) + " %"
        }
        return "ROI(last week): " + "-" + " %"
    }
    
    var roiLast1Month: String {
        if let roiData1Month = roiData["percentChangeLast1Month"] {
            return "ROI(last month): " + String(format: "%.6f", roiData1Month) + " %"
        }
        return "ROI(last month): " + "-" + " %"
    }
    
    var roiLast1Year: String {
        if let roiData1Year = roiData["percentChangeLast1Year"] {
            return "ROI(last year): " + String(format: "%.6f", roiData1Year) + " %"
        }
        return "ROI(last year): " + "-" + " %"
    }
    
    
    init?(coinModelData: CoinModelData) {
        name = coinModelData.data?.name ?? "No data"
        priceUSD = coinModelData.data?.marketData.priceUsd
        percentChangeUSDperDay = coinModelData.data?.marketData.percentChangeUSDperDay
        roiData = coinModelData.data?.roiData?.keysToCamelCase() ?? [:]
    }
}
