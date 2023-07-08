//
//  Result.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

@available(*, deprecated)
public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
