//
//  Router.swift
//  QuizforEngine
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer

    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(result: Result<Question, Answer>)
}
