//
//  Player.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

enum Player: CaseIterable {

    case playerX, playerO, none

    var symbol: String {
        switch self {
        case .playerX:
            return "xmark"
        case .playerO:
            return "circle"
        case .none:
            return ""
        }
    }
}
