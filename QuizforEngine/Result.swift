//
//  Result.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
