//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import Combine
import Foundation

public class QuestionGroup: Codable {

    public class Score: Codable {

        // MARK: - Properties

        public var correctCount = 0 {
            didSet { updateRunningPercentage() }
        }
        public var incorrectCount = 0 {
            didSet { updateRunningPercentage() }
        }

        @Published public var runningPercentage: Double = 0

        // MARK: - Object Lifecycle

        public init() {}

        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }

        public required init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            correctCount = try container.decode(Int.self, forKey: .correctCount)
            incorrectCount = try container.decode(
                Int.self,
                forKey: .incorrectCount
            )

            updateRunningPercentage()
        }

        // MARK: - Instance methods

        private func updateRunningPercentage() {
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                runningPercentage = 0

                return
            }

            runningPercentage = Double(correctCount) / Double(totalCount)
        }

        public func reset() {
            correctCount = 0
            incorrectCount = 0
        }

    }

    // MARK: - Properties

    public let title: String
    public let questions: [Question]
    public private(set) var score: Score

    // MARK: - Object Lifecycle

    public init(questions: [Question], score: Score, title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }

}
