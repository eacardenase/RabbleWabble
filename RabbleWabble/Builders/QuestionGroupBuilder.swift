//
//  QuestionGroupBuilder.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/18/26.
//

import Foundation

public class QuestionBuilder {
    public enum Error: String, Swift.Error {
        case missingAnswer
        case missingPrompt
    }

    public var answer = ""
    public var hint: String?
    public var prompt = ""

    public func build() throws -> Question {
        guard !answer.isEmpty else { throw Error.missingAnswer }
        guard !prompt.isEmpty else { throw Error.missingPrompt }

        return Question(answer: answer, hint: hint, prompt: prompt)
    }
}

public class QuestionGroupBuilder {
    public enum Error: String, Swift.Error {
        case missingTitle
        case missingQuestions
    }

    public var questions = [QuestionBuilder()]
    public var title = ""

    public func addNewQuestion() {
        let question = QuestionBuilder()
        questions.append(question)
    }

    public func removeQuestion(at index: Int) {
        questions.remove(at: index)
    }

    public func build() throws -> QuestionGroup {
        guard !title.isEmpty else { throw Error.missingTitle }
        guard !questions.isEmpty else { throw Error.missingQuestions }

        let questions = try questions.map { try $0.build() }

        return QuestionGroup(
            questions: questions,
            title: title
        )
    }
}
