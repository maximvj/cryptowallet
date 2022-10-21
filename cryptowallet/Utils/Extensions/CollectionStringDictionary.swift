
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
            if let valueString = value as? Dictionary,
               let valueCamelcase = valueString.keysToCamelCase() as? Value {
                value = valueCamelcase
            }

            var newKey = key
            if let keyString = key as? String,
               let keyCamelCase = keyString.underscoreToCamelCase as? Key {
                newKey = keyCamelCase
            }
            
            dict[newKey] = value
        }

        return dict
    }
}
