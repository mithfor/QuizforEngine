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
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [],
                       router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"],
                       router: router)
        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"],
                       router: router)
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"],
                       router: router)
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q2")
    }
}

class RouterSpy: Router {
    var routedQuestionCount: Int = 0
    var routedQuestion: String? = nil
    
    func routeTo(question: String) {
        routedQuestionCount += 1
        routedQuestion = question
    }
}
 
