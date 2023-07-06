//
//  QuestionTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation
import XCTest
@testable import QuizforEngine

class QuestionTest: XCTestCase {

    func test_withSameWrappedValue_isDifferentForSingleAndMultipleAnswer() {
        let aValue = UUID()

        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue,
                          Question.multipleAnswer(aValue).hashValue)
    }

    func test_hashValue_forSingleAnswer_returnsTypeHash() {

        let aValue = UUID()
        let anotherValue = UUID()

        XCTAssertEqual(Question.singleAnswer(aValue).hashValue,
                       Question.singleAnswer(aValue).hashValue)

        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue,
                       Question.singleAnswer(anotherValue).hashValue)

    }

    func test_hashValue_forMultipleAnswer() {

        let aValue = UUID()
        let anotherValue = UUID()

        XCTAssertEqual(Question.multipleAnswer(aValue).hashValue,
                       Question.multipleAnswer(aValue).hashValue)

        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue,
                       Question.multipleAnswer(anotherValue).hashValue)
    }
}
