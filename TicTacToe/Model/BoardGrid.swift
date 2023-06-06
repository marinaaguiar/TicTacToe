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

    mutating func updateItemOnGrid(row: Int, section: Int, player: Player) {
        let position = grid[row][section]
        
        if position.player == .none {
            grid[row][section].player = player
        }
    }

    mutating func numberOfCells() -> Int {
        return grid.flatMap{ $0 }.count
    }
}

