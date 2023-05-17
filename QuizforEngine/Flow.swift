//
//  Flow.swift
//  QuizforEngine
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

final class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String],
         router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}
