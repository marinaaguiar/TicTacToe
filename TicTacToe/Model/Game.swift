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

    private var currentPlayerTurn: Player {
        return playerTurn.currentPlayerTurn
    }

    init() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
    }

    private mutating func startGame() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
    }

    mutating func resetGame() {
        startGame()
    }

    mutating func playMove(_ move: Move) {
        boardGrid.updateItemOnGrid(move: move)
        print(boardGrid)
        if isThereAWinner(for: move) {
            print("Game Winner is \(move.player)")
        } else {
            updatePlayer()
        }
    }

    mutating func isThereAWinner(for move: Move) -> Bool {

        if boardGrid.hasRowFilled(row: move.position.row, for: move.player) {
            print("row filled win \(move.player)")
            return true
        }

        if boardGrid.hasColumnFilled(column: move.position.column, for: move.player) {
            print("column filled win \(move.player)")
            return true
        }

        if boardGrid.hasDiagonalFilled(for: move.player) {
            print("Diagonal filled win \(move.player)")
            return true
        }
        return false
    }

    mutating func getItemOnGrid(position: Position) -> Move {
        let items = boardGrid.grid
        return items[position.row][position.column]
    }

    mutating func updatePlayer() {
        playerTurn.switch()
    }

    func getNumberOfRowsOnGrid() -> Int {
        return boardGrid.numberOfRows
    }

    func getCurrentPlayer() -> Player {
        return currentPlayerTurn
    }
}
