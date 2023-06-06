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

    func getItemOnGrid(row: Int, section: Int) -> Cell {
        return game.getItemOnGrid(row: row, section: section)
    }

    func playMove(position: (row: Int, section: Int), for player: Player) {
        game.playMove(row: position.row, section: position.section, for: player)
    }

    func getCurrentPlayer() -> Player {
        return game.currentPlayerTurn
    }
}
