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
}
