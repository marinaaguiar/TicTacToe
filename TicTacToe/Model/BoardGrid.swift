//
//  BoardGrid.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 5/25/23.
//

import Foundation

class BoardGrid {

    private var rowsCount: Int = 3
    lazy var grid: [[Move]] = []
    
    var numberOfRows: Int {
        return rowsCount
    }

    init() {
        populateGrid()
    }

    private func populateGrid() {
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

    func updateItemOnGrid(move: Move) {
        let row = move.position.row
        let column = move.position.column
        let position = grid[row][column]
        
        if position.player == .none {
            grid[row][column].player = move.player
        }
    }

    func numberOfCells() -> Int {
        return grid.flatMap{ $0 }.count
    }

    func isGridFilled() -> Bool {
        for row in grid {
            for cell in row {
                if cell.player == TicTacToe.Player.none {
                    return false
                }
            }
        }
        return true
    }

    func changeNumberOfRows(for value: Int) {
        rowsCount = value
    }
}
