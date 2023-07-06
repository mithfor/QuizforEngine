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
    let flow = Flow(questions: questions, delegate: delegate, scoring: { scoring($0, correctAnswers: correctAnswers) })
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
