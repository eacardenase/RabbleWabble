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

    // MARK: - Properties

    public var title: String {
        switch self {
        case .random: return "Random"
        case .sequential: return "Sequential"
        }
    }

    // MARK: - Instance Methods

    public func questionStrategy(
        for questionGroupCaretaker: QuestionGroupCaretaker
    ) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(
                questionGroupCaretaker: questionGroupCaretaker
            )
        case .sequential:
            return SequentialQuestionStrategy(
                questionGroupCaretaker: questionGroupCaretaker
            )
        }
    }

}

public class AppSettings {

    // MARK: - Properties

    public static let shared = AppSettings()

    public var questionStrategyType: QuestionStrategyType {
        get {
            guard
                let rawValue = UserDefaults.standard.object(
                    forKey: String(describing: QuestionStrategyType.self)
                ) as? Int
            else {
                return .sequential
            }

            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            UserDefaults.standard.setValue(
                newValue.rawValue,
                forKey: String(describing: QuestionStrategyType.self)
            )
        }
    }

    // MARK: - Object Lifecycle

    private init() {}

    // MARK: - Instance Methods

    public func questionStrategy(
        for questionGroupCaretaker: QuestionGroupCaretaker
    ) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(
            for: questionGroupCaretaker
        )
    }

}
