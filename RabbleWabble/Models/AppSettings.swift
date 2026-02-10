//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/9/26.
//

import Foundation

public enum QuestionStrategyType: Int, CaseIterable {

    case random
    case sequential

    public var title: String {
        switch self {
        case .random: return "Random"
        case .sequential: return "Sequential"
        }
    }

    public func questionStrategy(
        for questionGroup: QuestionGroup
    ) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroup: questionGroup)
        case .sequential:
            return SequentialQuestionStrategy(questionGroup: questionGroup)
        }
    }

}

public class AppSettings {

    // MARK: - Keys

    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }

    // MARK: - Properties

    public static let shared = AppSettings()

    public var questionStrategyType: QuestionStrategyType {
        get {
            guard
                let rawValue = UserDefaults.standard.object(
                    forKey: Keys.questionStrategy
                ) as? Int
            else {
                return .sequential
            }

            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            UserDefaults.standard.setValue(
                newValue.rawValue,
                forKey: Keys.questionStrategy
            )
        }
    }

    // MARK: - Initializers

    private init() {}

    public func questionStrategy(
        for questionGroup: QuestionGroup
    ) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroup)
    }

}
