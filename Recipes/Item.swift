//
//  Item.swift
//  Recipes
//
//  Created by Riley Marshall on 11/28/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
