//
//  BoardGrid.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

struct BoardGrid {

    private let rowsCount: Int = 3

    lazy var grid: [[Cell]] = []

    var numberOfRows: Int {
        return rowsCount
    }

    init() {
        populateGrid()
    }

    private mutating func populateGrid() {

        for row in 0..<rowsCount {
            var newRow: [Cell] = []

            for col in 0..<rowsCount {
                let cell = Cell(position: (row, col), player: .none)
                newRow.append(cell)
            }

            grid.append(newRow)
        }

        print(grid)
    }

    mutating func updateItemOnGrid(row: Int, column: Int, player: Player) {
        let position = grid[row][column]
        
        if position.player == .none {
            grid[row][column].player = player
        }
    }

    mutating func numberOfCells() -> Int {
        return grid.flatMap{ $0 }.count
    }

    mutating func hasRowFilled(row: Int, for player: Player) -> Bool {
        return grid[row].allSatisfy({ $0.player == player })
    }

    mutating func hasColumnFilled(column: Int, for player: Player) -> Bool {
        var columnCells: [Cell] = []

        for row in 0..<numberOfRows {
            if grid[row][column].player == player {
                columnCells.append(grid[row][column])
            }
        }

        return columnCells.count == numberOfRows
    }

    mutating func hasDiagonalFilled(position: (Int, Int), for player: Player) -> Bool {
        var lastIndex = numberOfRows - 1
        var leftDiagonalCells: [Cell] = []
        var rightDiagonalCells: [Cell] = []

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

