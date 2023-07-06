//
//  Question.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation

public enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    public func hash(into hasher: inout Hasher) {

        switch self {
        case .singleAnswer(let value):
            hasher.combine(value.hashValue ^ "singleAnswer".hashValue)

        case .multipleAnswer(let value):
            hasher.combine(value.hashValue ^ "multipleAnswer".hashValue)
        }
    }
}
