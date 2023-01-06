//
//  DrinksController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/28.
//

import Foundation

class DrinksController {
    struct Drink: Hashable {
        let name: String
        let ml: Int
        let identifier = UUID()
        
        // snapshot을 생성 및 비교하기 위해 고유한 identifier가 필요
        // 따라서 Hashable 프로토콜 준수
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func ==(lhs: Drink, rhs: Drink) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return name.lowercased().contains(lowercasedFilter)
        }
    }
    
    func filteredDrinks(with filter: String?=nil, limit: Int?=nil) -> [Drink] {
        let filtered = drinks.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    
    private lazy var drinks: [Drink] = {
        return generateDrinks()
    }()
}

extension DrinksController {
    // RawData를 [Drink]로 반환
    private func generateDrinks() -> [Drink] {
        let components = drinksRawData.components(separatedBy: CharacterSet.newlines)
        var drinks = [Drink]()
        for line in components {
            let drinkComponents = line.components(separatedBy: ",")
            let name = drinkComponents[0]
            let ml = Int(drinkComponents[1])
            drinks.append(Drink(name: name, ml: ml!))
        }
        return drinks
    }
}
