//
//  Cell.swift
//  TicTacToe
//
//  Created by Marina Aguiar on 6/6/23.
//

import Foundation

struct Move {
    let position: Position
    var player: Player
}

struct Position: Hashable {
    let row: Int
    let column: Int
}
