//
//  QuestionController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import UIKit

public class QuestionController: UIViewController {

    // MARK: - Properties

    public let questionView = QuestionView()
    public let questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        showQuestion()
    }

}

// MARK: - Helpers

extension QuestionController {

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(questionView)

        // questionView
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            questionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            questionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            questionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }

    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
    }

}
