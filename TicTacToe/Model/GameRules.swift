//
//  GameRules.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 6/15/23.
//

import Foundation

enum GameState: Equatable {
    case playerWins(Player)
    case tie
    case idle
}

enum WinnerCase {
    case rowFilled([Move])
    case columnFilled([Move])
    case diagonalFilled([Move])
    case none
}

protocol GameStateDelegate: AnyObject {
    func didUpdate(with state: GameState)
}

struct GameRulesCalculator {

    private var boardGrid: BoardGrid
    private var grid: [[Move]]
    var winnerCase: WinnerCase

    init(boardGrid: BoardGrid) {
        self.boardGrid = boardGrid
        self.grid = self.boardGrid.grid
        self.winnerCase = .none
    }

    mutating func applyRules(for move: Move) -> GameState {
        if hasRowFilled(row: move.position.row, for: move.player) {
            print("row filled win \(move.player)")
            return .playerWins(move.player)
        }

        if hasColumnFilled(column: move.position.column, for: move.player) {
            print("column filled win \(move.player)")
            return .playerWins(move.player)
        }

        if hasDiagonalFilled(for: move.player) {
            print("Diagonal filled win \(move.player)")
            return .playerWins(move.player)
        }

        if boardGrid.isGridFilled() {
            print("Tie")
            return .tie
        }
        return .idle
    }

    private mutating func hasRowFilled(row: Int, for player: Player) -> Bool {
        if grid[row].allSatisfy({ $0.player == player }) {
            winnerCase = .rowFilled(grid[row])
            return true
        }
        return false
    }

    private mutating func hasColumnFilled(column: Int, for player: Player) -> Bool {
        var columnCells: [Move] = []
        let numberOfRows = boardGrid.numberOfRows

        for row in 0..<numberOfRows {
            if grid[row][column].player == player {
                columnCells.append(grid[row][column])
            }
        }

        if columnCells.count == numberOfRows {
            winnerCase = .columnFilled(columnCells)
            return true
        }
        return false
    }

    private mutating func hasDiagonalFilled(for player: Player) -> Bool {
        let numberOfRows = boardGrid.numberOfRows
        var lastIndex = numberOfRows - 1
        var leftDiagonalCells: [Move] = []
        var rightDiagonalCells: [Move] = []

        for i in 0..<numberOfRows {
            if grid[i][i].player == player {
                leftDiagonalCells.append(grid[i][i])
            }

            if grid[i][lastIndex].player == player {
                rightDiagonalCells.append(grid[i][lastIndex])
                lastIndex -= 1
            }
        }

        if leftDiagonalCells.count == numberOfRows {
            winnerCase = .diagonalFilled(leftDiagonalCells)
            return true
        } else if rightDiagonalCells.count == numberOfRows {
            winnerCase = .diagonalFilled(rightDiagonalCells)
            return true
        }
        return false
    }
}
