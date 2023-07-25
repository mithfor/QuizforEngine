//
//  Flow.swift
//  QuizforEngine
//
//  Created by Dmitrii Voronin on 17.05.2023.
//

import Foundation

final class Flow<Delegate: QuizDelegate, DataSource: QuizDataSource> where Delegate.Question == DataSource.Question, Delegate.Answer == DataSource.Answer{

    typealias Question = Delegate.Question
    typealias Answer = Delegate.Answer

    private let questions: [Question]
    private let delegate: Delegate
    private let dataSource: DataSource

    private var answers: [(Question, Answer)] = []

    init(questions: [Question], delegate: Delegate, dataSource: DataSource) {
        self.questions = questions
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    func start() {
        delegateQuestionHandling(at: questions.startIndex)
    }

    private func delegateQuestionHandling(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            dataSource.answer(for: question, completion: answer(for: question, at: index))

        } else {
            delegate.didCompleteQuiz(withAnswers: answers)
        }
    }

    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }

    private func answer(for question: Question, at index: Int) -> (DataSource.Answer) -> Void {
        return { [weak self] answer in
            self?.answers.append((question, answer))
            self?.delegateQuestionHandling(after: index)
        }
    }
}

