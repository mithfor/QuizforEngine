//
//  Game.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

@available(*, deprecated)
public class Game <Delegate: QuizDelegate>{
    let flow: Flow<Delegate>

    init(flow: Flow<Delegate>) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question: Hashable,
                      Answer: Equatable,
                      Delegate: QuizDelegate>(questions: [Question],
                                 delegate: Delegate,
                                 correctAnswers: [Question: Answer]) -> Game<Delegate> where Delegate.Question == Question, Delegate.Answer ==  Answer {
    let flow = Flow(questions: questions, delegate: delegate)
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated)
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate where R.Answer: Equatable {

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

    func handle(result: Result<R.Question, R.Answer>) {}

    private func scoring(_ answers: [R.Question: R.Answer], correctAnswers: [R.Question: R.Answer]) -> Int {
        return answers.reduce(0) { (score, tuple) in
            return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
        }
    }
}


