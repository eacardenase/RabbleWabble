//
//  CreateQuestionCell.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/17/26.
//

import UIKit

// MARK: - CreateQuestionCellDelegate

public protocol CreateQuestionCellDelegate {
    func createQuestionCell(
        _ cell: CreateQuestionCell,
        answerTextDidChange text: String
    )
    func createQuestionCell(
        _ cell: CreateQuestionCell,
        hintTextDidChange text: String
    )
    func createQuestionCell(
        _ cell: CreateQuestionCell,
        promptTextDidChange text: String
    )
}

// MARK: - CreateQuestionCell

public class CreateQuestionCell: UITableViewCell {

    // MARK: - Properties

    public var delegate: CreateQuestionCellDelegate?

    public var indexLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Question 1"
        label.font = .preferredFont(forTextStyle: .headline)

        return label
    }()

    public var promptTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Answer"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)

        return textField
    }()

    public var hintTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Hint (optional)"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)

        return textField
    }()

    public var answerTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Prompt"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)

        return textField
    }()

    // MARK: - View Lifecycle

    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension CreateQuestionCell {

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            indexLabel, promptTextField, hintTextField, answerTextField,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        contentView.addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
        ])
    }

}

// MARK: - Actions
extension CreateQuestionCell {
    @objc public func answerTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, answerTextDidChange: textField.text!)
    }

    @objc public func hintTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, hintTextDidChange: textField.text!)
    }

    @objc public func promptTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, promptTextDidChange: textField.text!)
    }
}

// MARK: - UITextFieldDelegate
extension CreateQuestionCell: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
