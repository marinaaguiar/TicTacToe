//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

class GameViewModel {

    private var game: Game!

    init() {
        startGame()
    }

    private func startGame() {
        game = Game(boardGrid: BoardGrid())
    }

    func resetGame() {
        startGame()
    }

    func getNumberOfRows() -> Int {
        game.getNumberOfRowsOnGrid()
    }

    func getItemOnGrid(row: Int, column: Int) -> Cell {
        return game.getItemOnGrid(row: row, column: column)
    }

    func playMove(position: (row: Int, column: Int), for player: Player) {
        game.playMove(row: position.row, column: position.column, for: player)
        print(game.boardGrid)
        var gameState = GameState(player: player, boardGrid: game.boardGrid)

        if gameState.hasRowFilled(row: position.row) {
            print("row filled win \(player)")
        }

        if gameState.hasColumnFilled(column: position.column) {
            print("column filled win \(player)")
        }

        if gameState.hasDiagonalFilled(row: position.row, column: position.column) {
            print("Diagonal filled win \(player)")
        }
    }

    func getCurrentPlayer() -> Player {
        return game.currentPlayerTurn
    }
}
