//
//  Game.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

final class Game {

    private var playerTurn: Turn
    private var boardGrid: BoardGrid
    weak var delegate: GameStateDelegate?
    private var state: GameState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    var gameState: GameState {
        return self.state
    }

    var winnerCase: WinnerCase

    private var currentPlayerTurn: Player {
        return playerTurn.currentPlayerTurn
    }

    init() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
        self.state = .idle
        self.winnerCase = .none
    }

    func startGame() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
        winnerCase = .none
    }

    func resetGame() {
        startGame()
    }

    func playMove(_ move: Move) {
        boardGrid.updateItemOnGrid(move: move)
        print(boardGrid)
        updateGameStates(move)

        if !gameIsOver() {
            updatePlayer()
        }
    }

    func updateGameStates(_ move: Move) {
        var gameRules = GameRulesCalculator(game: self, boardGrid: boardGrid)
        state = gameRules.applyRules(for: move)
    }

    func getWinnerCells() -> [Move] {
        switch winnerCase {
        case .rowFilled(let moves):
            return moves
        case .columnFilled(let moves):
            return moves
        case .diagonalFilled(let moves):
            return moves
        case .none:
            return []
        }
    }

    private func gameIsOver() -> Bool {
        return state != .idle
    }

    func getItemOnGrid(position: Position) -> Move {
        let items = boardGrid.grid
        return items[position.row][position.column]
    }

    func updatePlayer() {
        playerTurn.switch()
    }

    func getNumberOfRowsOnGrid() -> Int {
        return boardGrid.numberOfRows
    }

    func getCurrentPlayer() -> Player {
        return currentPlayerTurn
    }
}
