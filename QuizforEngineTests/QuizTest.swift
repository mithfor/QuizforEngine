//
//  QuizTest.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 06.07.2023.
//

import Foundation
import XCTest
import QuizforEngine

class QuizTest: XCTestCase {
    private let delegate = DelegateSpy()
    private var quiz: Quiz!

    override func setUp() {
        super.setUp()

        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1":"A1", "Q2":"A2" ])
    }

    func test_startQuiz_answerZeroOutOfTwoCorrectly_scoresZero() {
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult!.score, 0)
    }

    func test_startQuiz_answerOneOutOfTwoCorrectly_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult!.score, 1)
    }

    func test_startQuiz_answerTwoOutOfTwoCorrectly_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(delegate.handledResult!.score, 2)
    }

    private class DelegateSpy: QuizDelegate {

        var handledResult: Result<String, String>? = nil
        var answerCallback: ((String) -> Void) = { _ in }

        func answer(for: String, completion: @escaping (String) -> Void) {
            self.answerCallback = completion
        }

        func handle(result: QuizforEngine.Result<String, String>) {
            handledResult = result
        }
    }
}
