//
//  RouterSpy.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation
import QuizforEngine

class RouterSpy: Router {

    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: ((String) -> Void) = { _ in }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }

    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
