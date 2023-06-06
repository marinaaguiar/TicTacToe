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
        playerTurn = .player1
    }

    mutating func `switch`() {
        if playerTurn == .player1 {
            playerTurn = .player2
        } else {
            playerTurn = .player1
        }
    }
}
