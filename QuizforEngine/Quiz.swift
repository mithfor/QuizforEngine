//
//  Quiz.swift
//  QuizforEngine
//
//  Created by Dmitriy Voronin on 06.07.2023.
//

import Foundation

public final class Quiz {

    private let flow: Any

    private init(flow: Any) {
        self.flow = flow
    }

    public static func start<Delegate: QuizDelegate>(
        questions: [Delegate.Question],
        delegate: Delegate,
        correctAnswers: [Delegate.Question: Delegate.Answer]
    ) -> Quiz where  Delegate.Answer: Equatable {
        let flow = Flow(
            questions: questions,
            delegate: delegate,
            scoring: { scoring($0, correctAnswers: correctAnswers) }
        )
        flow.start()
        return Quiz(flow: flow)
    }
}

func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
