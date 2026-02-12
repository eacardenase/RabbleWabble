//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/7/26.
//

import Foundation

public class RandomQuestionStrategy: BaseQuestionStrategy {

    // MARK: - Initializers

    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions.shuffled()

        self.init(
            questionGroupCaretaker: questionGroupCaretaker,
            questions: questions
        )
    }

}
