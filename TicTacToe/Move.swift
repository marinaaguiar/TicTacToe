//
//  Move.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/18/23.
//

import Foundation

struct Move {
    let player: Player
    let boardIndex: Int

    var indicator: String {
        switch player {
        case .human:
            return "xmark"
        case .computer:
            return "circle"
        }
    }
}
