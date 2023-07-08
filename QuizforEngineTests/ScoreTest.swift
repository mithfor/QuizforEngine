//
//  ScoreTest.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 08.07.2023.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {

    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: []), 0)
    }

    private class BasicScore {
        static func score(for: [Any]) -> Int {
            return 0
        }
    }
}
