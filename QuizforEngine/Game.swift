//
//  Game.swift
//  
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import Foundation

public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) where R.Question == Question, R.Answer ==  Answer {

}
