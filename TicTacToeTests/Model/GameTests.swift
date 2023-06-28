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
        var expectedResult: Player = .playerO

        switch currentPlayer {
        case .playerX:
            game.updatePlayer()
            expectedResult = .playerO
            XCTAssertEqual(game.getCurrentPlayer(), expectedResult)
        case .playerO:
            game.updatePlayer()
            expectedResult = .playerX
            XCTAssertEqual(game.getCurrentPlayer(), expectedResult)
        case .none:
            break
        }
    }

    func testStartWithPlayerX() {
        let gameFirstTurn = game.getCurrentPlayer()
        XCTAssertEqual(gameFirstTurn, .playerX)
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

    func testMoveForPlayer1() {
        let position = Position(row: 0, column: 0)
        let movePlayer1 = Move(position: position, player: .playerX)

        boardGrid.updateItemOnGrid(move: movePlayer1)

        let cell = boardGrid.grid[position.row][position.column]
        XCTAssertEqual(cell.player, .playerX)
    }

    func testMoveForPlayer2() {
        let position = Position(row: 0, column: 2)
        let movePlayer2 = Move(position: position, player: .playerO)

        boardGrid.updateItemOnGrid(move: movePlayer2)

        let cell = boardGrid.grid[position.row][position.column]
        XCTAssertEqual(cell.player, .playerO)
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

    func testPlayerXWinsOnDiagonal() {
        let numberOfRows = boardGrid.numberOfRows

        for i in 0..<numberOfRows {
            let position = Position(row: i, column: i)
            let movePlayerX = Move(position: position, player: .playerX)
            game.playMove(movePlayerX)
        }
        XCTAssertEqual(game.gameState, .playerWins(.playerX))
    }

    func testPlayerOWinsOnLeftDiagonal() {
        let numberOfRows = boardGrid.numberOfRows
        var lastIndex = numberOfRows - 1

        for i in 0..<numberOfRows {
            let position = Position(row: i, column: lastIndex)
            let movePlayerO = Move(position: position, player: .playerO)
            game.playMove(movePlayerO)
            lastIndex -= 1
        }
        XCTAssertEqual(game.gameState, .playerWins(.playerO))
    }

    func testPlayerOWinsOnRow() {
        let numberOfRows = boardGrid.numberOfRows

        for i in 0..<numberOfRows {
            let position = Position(row: 0, column: i)
            let movePlayerO = Move(position: position, player: .playerO)
            game.playMove(movePlayerO)
        }
        XCTAssertEqual(game.gameState, .playerWins(.playerO))
    }

    func testPlayerOWinsOnColumn() {
        let numberOfRows = boardGrid.numberOfRows

        for i in 0..<numberOfRows {
            let position = Position(row: i, column: 0)
            let movePlayerO = Move(
                position: position,
                player: .playerO)
            game.playMove(movePlayerO)
        }
        XCTAssertEqual(game.gameState, .playerWins(.playerO))
    }
}
