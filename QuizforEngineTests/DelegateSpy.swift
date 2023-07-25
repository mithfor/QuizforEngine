//
//  DelegateSpy.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 08.07.2023.
//

import Foundation
import QuizforEngine

class DelegateSpy: QuizDelegate {

    var completedQuizzes: [[(String, String)]] = []

    func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}

class DataSourceSpy: QuizDataSource {

    var questionAsked: [String] = []
    var answerCompletions: [((String) -> Void)] = []

    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionAsked.append(question)
        self.answerCompletions.append(completion)
    }
}

