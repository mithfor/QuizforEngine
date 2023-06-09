//
//  Flow.swift
//  QuizforEngine
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation

final class Flow<Delegate: QuizDelegate>{

    typealias Question = Delegate.Question
    typealias Answer = Delegate.Answer
    
    private let delegate: Delegate
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question],
         delegate: Delegate,
         scoring: @escaping ([Question: Answer]) -> Int) {
        self.delegate = delegate
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {

        delegateQuestionHandling(at: questions.startIndex)
        
    }

    private func delegateQuestionHandling(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            delegate.answer(for: question, completion: answer(for: question, at: index))
        } else {
            delegate.handle(result: result())
        }
    }

    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }

    private func answer(for question: Question, at index: Int) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.answers[question] = answer
            self?.delegateQuestionHandling(after: index)
        }
    }

    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}

