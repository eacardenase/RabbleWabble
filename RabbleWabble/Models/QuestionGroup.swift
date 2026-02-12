//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import Foundation

public class QuestionGroup: Codable {

    public class Score: Codable {
        public var correctCount = 0
        public var incorrectCount = 0

        public init() {}
    }

    // MARK: - Properties

    public let title: String
    public let questions: [Question]
    public var score: Score

    // MARK: - Object Lifecycle

    public init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }

}
