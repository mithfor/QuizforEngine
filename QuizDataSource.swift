//
//  QuizDataSource.swift
//  QuizforEngine
//
//  Created by Dmitriy Voronin on 25.07.2023.
//

import Foundation

public protocol QuizDataSource {
    associatedtype Question
    associatedtype Answer

    func answer(for question: Question, completion: @escaping (Answer) -> Void)
}
