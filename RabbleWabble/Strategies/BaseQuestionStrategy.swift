//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/11/26.
//

import Foundation

public class BaseQuestionStrategy {

    // MARK: - Properties

    private var questionGroupCaretaker: QuestionGroupCaretaker
    private var questionGroup: QuestionGroup {
        questionGroupCaretaker.selectedQuestionGroup
    }

    private let questions: [Question]
    public var questionIndex = 0

    public var correctCount: Int {
        get { questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }
    public var incorrectCount: Int {
        get { questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }

    // MARK: - Object Lifecycle

    public init(
        questionGroupCaretaker: QuestionGroupCaretaker,
        questions: [Question]
    ) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionGroupCaretaker.selectedQuestionGroup.score.reset()
    }

}

// MARK: - QuestionStrategy

extension BaseQuestionStrategy: QuestionStrategy {

    public var title: String {
        return questionGroup.title
    }

    public var questionIndexTitle: String {
        return "\(questionIndex + 1)/\(questions.count)"
    }

    public var currentQuestion: Question {
        return questions[questionIndex]
    }

    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()

        guard questionIndex + 1 < questions.count else {
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
