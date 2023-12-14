//
//  Item.swift
//  Recipes
//
//  Created by Riley Marshall on 11/28/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var timestamp: Date
    var instructions: [Instruction]

    init(timestamp: Date, instructions: [Instruction]) {
        self.timestamp = timestamp
        self.instructions = instructions
    }
}

@Model
final class Instruction {
    var sequence: Int
    var instructions: String

    init(sequence: Int, instructions: String) {
        self.sequence = sequence
        self.instructions = instructions
    }
}
