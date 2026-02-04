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

        questionView.delegate = self

        setupViews()
        showQuestion()

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(toggleAnswerLabels)
        )

        view.addGestureRecognizer(tapGesture)
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

    private func showNextQuestion() {
        questionIndex += 1

        guard questionIndex < questionGroup.questions.count else {
            return
        }

        showQuestion()
    }

}

// MARK: - Actions

extension QuestionController {

    @objc func toggleAnswerLabels(_ sender: UIView) {
        questionView.answerLabel.isHidden.toggle()
        questionView.hintLabel.isHidden.toggle()
    }

}

// MARK: - QuestionViewDelegate

extension QuestionController: QuestionViewDelegate {

    public func incorrectButtonTapped(_ sender: UIButton) {
        incorrectCount += 1

        questionView.incorrectCountLabel.text = "\(incorrectCount)"

        showNextQuestion()
    }

    public func correctButtonTapped(_ sender: UIButton) {
        correctCount += 1

        questionView.correctCountLabel.text = "\(correctCount)"

        showNextQuestion()
    }

}
