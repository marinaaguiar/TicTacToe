//
//  Player.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

enum Player: CaseIterable {

    case player1, player2, none

    var symbol: String {
        switch self {
        case .player1:
            return "xmark"
        case .player2:
            return "circle"
        case .none:
            return ""
        }
    }
}
