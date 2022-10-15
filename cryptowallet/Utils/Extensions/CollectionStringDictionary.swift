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

extension String {

    var underscoreToCamelCase: String {
        let items = self.components(separatedBy: "_")
        var camelCase = ""
        items.enumerated().forEach {
            camelCase += 0 == $0 ? $1 : $1.capitalized
        }
        return camelCase
    }
}

extension Dictionary {

    func keysToCamelCase() -> Dictionary {

        let keys = Array(self.keys)
        let values = Array(self.values)
        var dict: Dictionary = [:]

        keys.enumerated().forEach { (index, key) in

            var value = values[index]
            if let v = value as? Dictionary,
               let vl = v.keysToCamelCase() as? Value {
                value = vl
            }

            var newKey = key
            if let k = key as? String,
               let ky = k.underscoreToCamelCase as? Key {
                newKey = ky
            }
            
            dict[newKey] = value
        }

        return dict
    }
}
