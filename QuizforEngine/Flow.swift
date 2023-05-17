//
//  Flow.swift
//  QuizforEngine
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
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
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        }
    }
    
    func routeNext(_ question: String) -> ((String) -> Void) {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            let currentQuestionIndex = strongSelf.questions.firstIndex(of: question)!
            let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
            
            strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(nextQuestion))
        }
    }
}
