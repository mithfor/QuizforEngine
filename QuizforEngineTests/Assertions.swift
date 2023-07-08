//
//  Assertions.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 08.07.2023.
//

import Foundation
import XCTest

func assertEqual(_ a1: [(String, String)],
                         _ a2: [(String, String)],
                         file: StaticString = #filePath,
                         line: UInt = #line) {
    XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
}
