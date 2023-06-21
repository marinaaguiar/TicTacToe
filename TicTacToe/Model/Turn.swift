//
//  Turn.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/26/23.
//

import Foundation

struct Turn {

    private var playerTurn: Player

    var currentPlayerTurn: Player {
        return playerTurn
    }
    
    init() {
        playerTurn = .playerX
    }

    mutating func `switch`() {
        if playerTurn == .playerX {
            playerTurn = .playerO
        } else {
            playerTurn = .playerX
        }
    }
}
