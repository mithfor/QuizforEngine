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

    public static func start<Delegate: QuizDelegate, DataSource: QuizDataSource>(questions: [Delegate.Question],
                                                                                 delegate: Delegate,
                                                                                 dataSource: DataSource) -> Quiz where  Delegate.Answer: Equatable, Delegate.Question == DataSource.Question, Delegate.Answer == DataSource.Answer{
        let flow = Flow(questions: questions,
                        delegate: delegate, dataSource: dataSource)
        flow.start()
        return Quiz(flow: flow)
    }
}

