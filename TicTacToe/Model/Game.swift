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
    weak var delegate: GameStateDelegate?
    private var state: GameState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    private var winnerCase: WinnerCase

    private var currentPlayerTurn: Player {
        return playerTurn.currentPlayerTurn
    }

    init() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
        self.state = .idle
        self.winnerCase = .none
    }

    private mutating func startGame() {
        playerTurn = Turn()
        boardGrid = BoardGrid()
        winnerCase = .none
    }

    mutating func resetGame() {
        startGame()
    }

    mutating func playMove(_ move: Move) {
        boardGrid.updateItemOnGrid(move: move)
        print(boardGrid)
        updateGameStates(move)

        if !gameIsOver() {
            updatePlayer()
        }
    }

    mutating func updateGameStates(_ move: Move) {
        var gameState = GameRulesCalculator(boardGrid: boardGrid)
        state = gameState.applyRules(for: move)
        if state == .playerWins(.playerX) || state == .playerWins(.playerO) {
            winnerCase = gameState.winnerCase
        }
    }

    mutating func getWinnerCells() -> [Move] {
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

    func gameIsOver() -> Bool {
        return state != .idle
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
