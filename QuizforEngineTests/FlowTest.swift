 //
//  FlowTest.swift
//  QuizforEngineTests
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation
import XCTest
@testable import QuizforEngine

class FlowTest: XCTestCase
{
    
    func test_start_withNoQuestions_doesNotDElegateToQuestionHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.questionAsked.isEmpty)
    }
    
    func test_start_withOneQuestion_delegatesToCorrectQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()

        XCTAssertEqual(delegate.questionAsked, ["Q1"])
    }
    
    func test_start_withOneQuestion_delegatesToAnotherCorrectQuestionHandling() {

        makeSUT(questions: ["Q2"]).start()

        XCTAssertEqual(delegate.questionAsked, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesToFirstQuestionHandling() {

        makeSUT(questions: ["Q1", "Q2"]).start()

        XCTAssertEqual(delegate.questionAsked, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_delegatesToFirstQuestionTwiceHandling() {

        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()

        XCTAssertEqual(delegate.questionAsked, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_delegatesToSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()

        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.questionAsked, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotDelegateToAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()


        delegate.answerCompletion("A1")

        XCTAssertEqual(delegate.questionAsked, ["Q1"])
    }

    func test_start_withOneQuestion_doesCompleteQuiz() {
        makeSUT(questions: ["Q1"]).start()

        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }
    
    func test_start_withNoQuestions_completeWithEmptyQuiz() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        XCTAssertTrue(delegate.completedQuizzes[0].isEmpty)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotCompleteQuiz() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()

        delegate.answerCompletion("A1")

        XCTAssertTrue(delegate.completedQuizzes.isEmpty)    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_completesQuiz() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()

        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")

        XCTAssertEqual(delegate.completedQuizzes.count, 1)

        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    // MARK: - Helpers

    private let delegate = DelegateSpy()

    private weak var weakSUT: Flow<DelegateSpy>?

    override func tearDown() {
        super.tearDown()

        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil")
    }
    
    private func makeSUT(questions: [String]) -> Flow<DelegateSpy>{
        let sut = Flow(questions: questions,
                    delegate: delegate)
        weakSUT = sut
        return sut
    }
}
