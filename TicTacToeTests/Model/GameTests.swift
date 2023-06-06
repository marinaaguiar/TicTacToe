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

    override func setUp() {
        super.setUp()
        game = Game()
    }

    override func tearDown() {
        game = nil
        super.tearDown()
    }

    func testSwitchPlayerTurn() {

        let currentPlayer = game.currentPlayerTurn
        var expectedResult: Player = .player2

        switch currentPlayer {
        case .player1:
            game.update()
            expectedResult = .player2
            XCTAssertEqual(game.currentPlayerTurn, expectedResult)
        case .player2:
            game.update()
            expectedResult = .player1
            XCTAssertEqual(game.currentPlayerTurn, expectedResult)
        case .none:
            break
        }
    }

}
