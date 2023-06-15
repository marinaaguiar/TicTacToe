//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Marina Aguiar on 5/29/23.
//

@testable import TicTacToe
import XCTest

final class GameTests: XCTestCase {

    var game: Game!
    var boardGrid: BoardGrid = BoardGrid()

    override func setUp() {
        super.setUp()
        game = Game()
    }

    override func tearDown() {
        game = nil
        super.tearDown()
    }

    func testSwitchPlayerTurn() {
        let currentPlayer = game.getCurrentPlayer()
        var expectedResult: Player = .player2

        switch currentPlayer {
        case .player1:
            game.updatePlayer()
            expectedResult = .player2
            XCTAssertEqual(game.getCurrentPlayer(), expectedResult)
        case .player2:
            game.updatePlayer()
            expectedResult = .player1
            XCTAssertEqual(game.getCurrentPlayer(), expectedResult)
        case .none:
            break
        }
    }

    func testStartWithPlayerX() {
        let gameFirstTurn = game.getCurrentPlayer()
        XCTAssertEqual(gameFirstTurn, .player1)
    }

    func testAllCellsEmptyWhenGameStart() {

        let rowsCount = boardGrid.numberOfRows
        for row in 0..<rowsCount {

            for col in 0..<rowsCount {
                let cell = boardGrid.grid[row][col]
                XCTAssertTrue(cell.player == .none)
            }
        }
    }

    func testIsCellEmpty() {
        let cell = boardGrid.grid[0][1]
        XCTAssertTrue(cell.player == .none)
    }

    func testMoveForPlayer1() {
        let position = Position(row: 0, column: 0)
        let movePlayer1 = Move(position: position, player: .player1)

        boardGrid.updateItemOnGrid(move: movePlayer1)

        let cell = boardGrid.grid[position.row][position.column]
        XCTAssertEqual(cell.player, .player1)
    }

    func testMoveForPlayer2() {
        let position = Position(row: 0, column: 2)
        let movePlayer2 = Move(position: position, player: .player2)

        boardGrid.updateItemOnGrid(move: movePlayer2)

        let cell = boardGrid.grid[position.row][position.column]
        XCTAssertEqual(cell.player, .player2)
    }

    func testResetGame() {
        game.resetGame()
        let rowsCount = boardGrid.numberOfRows
        for row in 0..<rowsCount {
            for col in 0..<rowsCount {
                let cell = boardGrid.grid[row][col]
                XCTAssertTrue(cell.player == .none)
            }
        }
    }
}
