//
//  DelegateSpy.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 08.07.2023.
//

import Foundation
import QuizforEngine

class DelegateSpy: QuizDelegate {

    var questionAsked: [String] = []
    var completedQuizzes: [[(String, String)]] = []
    var answerCompletion: ((String) -> Void) = { _ in }

    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionAsked.append(question)
        self.answerCompletion = completion
    }

    func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
