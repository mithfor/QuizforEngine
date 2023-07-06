//
//  QuizDelegate.swift
//  QuizforEngine
//
//  Created by Dmitriy Voronin on 06.07.2023.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer

    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: QuizResult<Question, Answer>)
}
