//
//  Game.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

@available(*, deprecated, message: "use Quiz instead")
public class Game <Question, Answer, R: Router>{
    let quiz: Quiz

    init(quiz: Quiz) {
        self.quiz = quiz
    }
}

@available(*, deprecated, message: "use Quiz.start instead")
public func startGame<Question: Hashable,
                      Answer: Equatable,
                      R: Router>(questions: [Question],
                                 router: R,
                                 correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer ==  Answer {

    let adapter = QuizDelegateToRouterAdapter(router, correctAnswers)
    let quiz = Quiz.start(questions: questions, delegate: adapter, dataSource: adapter)

    return Game(quiz: quiz)
}


@available(*, deprecated, message: "Remove along with the deprecated Game types")
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate & QuizDataSource where R.Answer: Equatable {

    private let router: R
    private let correctAnswers: [R.Question: R.Answer]

    init(_ router: R, _ correctAnswers: [R.Question : R.Answer]) {
        self.router = router
        self.correctAnswers = correctAnswers
    }

    func answer(for question: R.Question, completion: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: completion)
    }

    func didCompleteQuiz(withAnswers answers: [(question: R.Question, answer: R.Answer)]) {
        let answersDictionary = answers.reduce([R.Question: R.Answer]()) { acc, tuple in
            var acc = acc
            acc[tuple.question] = tuple.answer
            return acc
        }
        let score = scoring(answersDictionary, correctAnswers: correctAnswers)
        let result = Result(answers: answersDictionary, score: score)
        router.routeTo(result: result)

    }

    private func scoring(_ answers: [R.Question: R.Answer], correctAnswers: [R.Question: R.Answer]) -> Int {
        return answers.reduce(0) { (score, tuple) in
            return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
        }
    }
}


