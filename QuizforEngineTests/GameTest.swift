//
//  GameTest.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation
import XCTest
import QuizforEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!

    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {

        self.game = startGame(questions: ["Q1", "Q2"],
                  router: router,
                  correctAnswers: ["Q1":"A1", "Q2":"A2" ])

        router.answerCallback("wrong")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 0)
    }

    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {

        self.game = startGame(questions: ["Q1", "Q2"],
                  router: router,
                  correctAnswers: ["Q1":"A1", "Q2":"A2" ])

        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 1)
    }

    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {

        self.game = startGame(questions: ["Q1", "Q2"],
                  router: router,
                  correctAnswers: ["Q1":"A1", "Q2":"A2" ])

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult!.score, 2)
    }
}
