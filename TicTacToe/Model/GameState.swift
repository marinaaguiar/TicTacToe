//
//  GameState.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 6/7/23.
//

import Foundation

struct GameState {

    private var player: Player
    private var boardGrid: BoardGrid

    init(player: Player, boardGrid: BoardGrid) {
        self.player = player
        self.boardGrid = boardGrid
    }

    mutating func hasRowFilled(row: Int) -> Bool {
        return boardGrid.hasRowFilled(row: row, for: player)
    }

    mutating func hasColumnFilled(column: Int) -> Bool {
        return boardGrid.hasColumnFilled(column: column, for: player)
    }

    mutating func hasDiagonalFilled(row: Int, column: Int) -> Bool {
        return boardGrid.hasDiagonalFilled(position: (row, column), for: player)
    }
}
