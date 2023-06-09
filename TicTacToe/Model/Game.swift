//
//  Game.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

struct Game {

    private var playerTurn: Turn
    var boardGrid: BoardGrid

    var currentPlayerTurn: Player {
        return playerTurn.currentPlayerTurn
    }

    init(boardGrid: BoardGrid) {
        self.boardGrid = boardGrid
        playerTurn = Turn()
    }

    mutating func playMove(row: Int, column: Int, for player: Player) {
        boardGrid.updateItemOnGrid(row: row, column: column, player: player)
        updatePlayer()
    }

    mutating func getItemOnGrid(row: Int, column: Int) -> Cell {
        let items = boardGrid.grid
        return items[row][column]
    }

    mutating func updatePlayer() {
        playerTurn.switch()
    }

    func getNumberOfRowsOnGrid() -> Int {
        return boardGrid.numberOfRows
    }
}
