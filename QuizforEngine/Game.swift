//
//  Game.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

@available(*, deprecated)
public class Game <Question, Answer, R: Router> where R.Question == Question, R.Answer ==  Answer {
    let flow: Flow<Question, Answer, R>

    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question: Hashable,
                      Answer: Equatable,
                      R: Router>(questions: [Question],
                                 router: R,
                                 correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer ==  Answer {
    let flow = Flow(questions: questions,
                    router: router, scoring: { scoring($0, correctAnswers: correctAnswers) })
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated)
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate {

    private let router: R

    init(_ router: R) {
        self.router = router
    }

    func handle(question: R.Question, answerCallback: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: answerCallback)
    }

    func handle(result: QuizResult<R.Question, R.Answer>) {
        router.routeTo(result: result)
    }
}

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
