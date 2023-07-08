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
    private var quiz: Quiz!

    func test_startQuiz_answersAllQuestions_completesWithAnswers() {

        let delegate = DelegateSpy()

        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")

        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
}
