//
//  Question.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import Foundation

public class Question: Codable {

    // MARK: - Properties

    public let answer: String
    public let hint: String?
    public let prompt: String

    // MARK: - Object Lifecycle

    public init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }

}
