//
//  BoardGrid.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

struct BoardGrid {

    private let rowsCount: Int = 3
    lazy var grid: [[Move]] = []
    var numberOfRows: Int {
        return rowsCount
    }

    init() {
        populateGrid()
    }

    private mutating func populateGrid() {
        for row in 0..<rowsCount {
            var newRow: [Move] = []

            for col in 0..<rowsCount {
                let cell = Move(position: Position(row: row, column: col), player: .none)
                newRow.append(cell)
            }
            grid.append(newRow)
        }
        print(grid)
    }

    mutating func updateItemOnGrid(move: Move) {
        let row = move.position.row
        let column = move.position.column
        let position = grid[row][column]
        
        if position.player == .none {
            grid[row][column].player = move.player
        }
    }

    mutating func numberOfCells() -> Int {
        return grid.flatMap{ $0 }.count
    }

    mutating func hasRowFilled(row: Int, for player: Player) -> Bool {
        return grid[row].allSatisfy({ $0.player == player })
    }

    mutating func hasColumnFilled(column: Int, for player: Player) -> Bool {
        var columnCells: [Move] = []

        for row in 0..<numberOfRows {
            if grid[row][column].player == player {
                columnCells.append(grid[row][column])
            }
        }

        return columnCells.count == numberOfRows
    }

    mutating func hasDiagonalFilled(for player: Player) -> Bool {
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
        return leftDiagonalCells.count == numberOfRows || rightDiagonalCells.count == numberOfRows
    }
}

