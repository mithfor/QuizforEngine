//
//  QuizDelegate.swift
//  QuizforEngine
//
//  Created by Dmitriy Voronin on 06.07.2023.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question
    associatedtype Answer

    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])

}

public protocol QuizDataSource {
    associatedtype Question
    associatedtype Answer

    func answer(for question: Question, completion: @escaping (Answer) -> Void)
}
