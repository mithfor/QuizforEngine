//
//  Flow.swift
//  QuizforEngine
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

final class Flow {
    
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String],
         router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: String) -> (Router.AnswerCallback) {
        return { [weak self] answer in
            guard let self = self else {return}
            self.routeNext(question,
                      answer)
        }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex =  questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            }
            
            router.routeTo(result: result)
        }
    }
}
