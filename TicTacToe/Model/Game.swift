//
//  Game.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

struct Game {

    private var playerTurn: Turn
    private var boardGrid: BoardGrid

    var currentPlayerTurn: Player {
        return playerTurn.currentPlayerTurn
    }

    init(boardGrid: BoardGrid) {
        self.boardGrid = boardGrid
        playerTurn = Turn()
    }

    mutating func playMove(row: Int, section: Int, for player: Player) {
        boardGrid.updateItemOnGrid(row: row, section: section, player: player)
        update()
    }

    mutating func getItemOnGrid(row: Int, section: Int) -> Cell {
        let items = boardGrid.grid
        return items[row][section]
    }

    mutating func update() {
        playerTurn.switch()
    }

    func getNumberOfRowsOnGrid() -> Int {
        return boardGrid.numberOfRows
    }
}
