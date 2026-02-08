//
//  QuestionController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import UIKit

public protocol QuestionControllerDelegate: AnyObject {

    func questionController(
        _ controller: QuestionController,
        didCancel questionStraregy: QuestionStrategy
    )

    func questionController(
        _ controller: QuestionController,
        didComplete questionStraregy: QuestionStrategy
    )

}

public class QuestionController: UIViewController {

    // MARK: - Properties

    public weak var delegate: QuestionControllerDelegate?

    public var questionStrategy: QuestionStrategy
    public let questionView = QuestionView()

    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: nil,
            action: nil
        )

        item.tintColor = .black
        navigationItem.rightBarButtonItem = item

        return item
    }()

    // MARK: - Initializers

    init(questionStrategy: QuestionStrategy) {
        self.questionStrategy = questionStrategy

        super.init(nibName: nil, bundle: nil)

        navigationItem.title = questionStrategy.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        questionView.delegate = self

        setupCancelButton()
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

    private func setupCancelButton() {
        let image = UIImage(resource: .icMenu)

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
    }

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
        let question = questionStrategy.currentQuestion

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true

        questionIndexItem.title = questionStrategy.questionIndexTitle
    }

    private func showNextQuestion() {
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionController(self, didComplete: questionStrategy)

            return
        }

        showQuestion()
    }

}

// MARK: - Actions

extension QuestionController {

    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.questionController(self, didCancel: questionStrategy)
    }

    @objc func toggleAnswerLabels(_ sender: UIView) {
        questionView.answerLabel.isHidden.toggle()
        questionView.hintLabel.isHidden.toggle()
    }

}

// MARK: - QuestionViewDelegate

extension QuestionController: QuestionViewDelegate {

    public func incorrectButtonTapped(_ sender: UIButton) {
        let question = questionStrategy.currentQuestion

        questionStrategy.markQuestionIncorrect(question)

        questionView.incorrectCountLabel.text =
            "\(questionStrategy.incorrectCount)"

        showNextQuestion()
    }

    public func correctButtonTapped(_ sender: UIButton) {
        let question = questionStrategy.currentQuestion

        questionStrategy.markQuestionCorrect(question)

        questionView.correctCountLabel.text = "\(questionStrategy.correctCount)"

        showNextQuestion()
    }

}
