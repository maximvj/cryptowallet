//
//  MainModel.swift
//  cryptowallet
//
//  Created by Maxim on 06.10.2022.
//

import Foundation

struct CoinModel {
    let name: String
    let priceUsd: Double
    let percentChangeUSDperDay: Double
    
    init?(coinModelData: CoinModelData) {
        name = coinModelData.data?.name ?? "No data"
        priceUsd = coinModelData.data?.marketData.priceUsd ?? 0
        percentChangeUSDperDay = coinModelData.data?.marketData.percentChangeUSDperDay ?? 0
    }
}
