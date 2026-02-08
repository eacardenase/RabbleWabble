//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/7/26.
//

import Foundation

public class RandomQuestionStrategy {

    // MARK: - Properties

    public var questionIndex = 0
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0

    private let questionGroup: QuestionGroup

    // MARK: - Initializers

    public init(questionGroup: QuestionGroup) {
        let randomizedQuestions = questionGroup.questions.shuffled()

        self.questionGroup = QuestionGroup(
            questions: randomizedQuestions,
            title: questionGroup.title
        )
    }

}

// MARK: - QuestionStrategy

extension RandomQuestionStrategy: QuestionStrategy {

    public var title: String {
        return questionGroup.title
    }

    public var questionIndexTitle: String {
        return "\(questionIndex + 1)/\(questionGroup.questions.count)"
    }

    public var currentQuestion: Question {
        return questionGroup.questions[questionIndex]
    }

    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else {
            return false
        }

        questionIndex += 1

        return true
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }

}
