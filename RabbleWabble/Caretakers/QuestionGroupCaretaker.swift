//
//  QuestionGroupCaretaker.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/11/26.
//

import Foundation

public final class QuestionGroupCaretaker {

    // MARK: - Properties

    private let fileName = "QuestionGroupData"
    public var questionGroups = [QuestionGroup]()
    public var selectedQuestionGroup: QuestionGroup!

    // MARK: - Object Lifecycle

    public init() {
        loadQuestionGroups()
    }

}

// MARK: - Helpers

extension QuestionGroupCaretaker {

    private func loadQuestionGroups() {
        if let retrievedQuestionGroups = try? DiskCaretaker.retrieve(
            [QuestionGroup].self,
            from: fileName
        ) {
            questionGroups = retrievedQuestionGroups

            return
        }

        let bundle = Bundle.main
        let url = bundle.url(forResource: fileName, withExtension: "json")!

        questionGroups = try! DiskCaretaker.retrieve(
            [QuestionGroup].self,
            from: url
        )

        try! save()
    }

    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }

}
