//
//  Extensions.swift
//  cryptowallet
//
//  Created by Maxim on 07.10.2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
