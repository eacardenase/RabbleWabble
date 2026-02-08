//
//  QuestionStrategy.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/7/26.
//

import Foundation

public protocol QuestionStrategy: AnyObject {

    var title: String { get }
    var questionIndexTitle: String { get }
    var currentQuestion: Question { get }
    var questionIndex: Int { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }

    func advanceToNextQuestion() -> Bool
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)

}
