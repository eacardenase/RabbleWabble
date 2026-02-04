//
//  QuestionView.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/3/26.
//

import UIKit

public protocol QuestionViewDelegate: AnyObject {

    func incorrectButtonTapped(_ sender: UIButton)
    func correctButtonTapped(_ sender: UIButton)

}

public class QuestionView: UIView {

    // MARK: - Properties

    weak var delegate: QuestionViewDelegate?

    public let answerLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Answer"
        label.font = .systemFont(ofSize: 48)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    public let promptLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Prompt"
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    public let hintLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hint"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    public lazy var incorrectButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .icCircleX), for: .normal)
        button.addTarget(
            self,
            action: #selector(incorrectButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    public let incorrectCountLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center

        return label
    }()

    public lazy var correctButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .icCircleCheck), for: .normal)
        button.addTarget(
            self,
            action: #selector(correctButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    public let correctCountLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center

        return label
    }()

    // MARK: - View Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension QuestionView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(promptLabel)
        addSubview(hintLabel)
        addSubview(answerLabel)
        addSubview(incorrectButton)
        addSubview(incorrectCountLabel)
        addSubview(correctButton)
        addSubview(correctCountLabel)

        // promptLabel
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            promptLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            promptLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // hintLabel
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(
                equalTo: promptLabel.bottomAnchor,
                constant: 8
            ),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // answerLabel
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(
                equalTo: hintLabel.bottomAnchor,
                constant: 50
            ),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // incorrectButton
        NSLayoutConstraint.activate([
            incorrectButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 32
            ),
            incorrectButton.bottomAnchor.constraint(
                equalTo: incorrectCountLabel.topAnchor,
                constant: -8
            ),
        ])

        // incorrectCountLabel
        NSLayoutConstraint.activate([
            incorrectCountLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24
            ),
            incorrectCountLabel.centerXAnchor.constraint(
                equalTo: incorrectButton.centerXAnchor
            ),
        ])

        // correctButton
        NSLayoutConstraint.activate([
            correctButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -32
            ),
            correctButton.bottomAnchor.constraint(
                equalTo: correctCountLabel.topAnchor,
                constant: -8
            ),
        ])

        // correctCountLabel
        NSLayoutConstraint.activate([
            correctCountLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24
            ),
            correctCountLabel.centerXAnchor.constraint(
                equalTo: correctButton.centerXAnchor
            ),
        ])
    }

}

// MARK: - Actions

extension QuestionView {

    @objc func incorrectButtonTapped(_ sender: UIButton) {
        delegate?.incorrectButtonTapped(sender)
    }

    @objc func correctButtonTapped(_ sender: UIButton) {
        delegate?.correctButtonTapped(sender)
    }

}
