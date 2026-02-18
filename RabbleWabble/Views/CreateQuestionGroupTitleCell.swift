//
//  CreateQuestionGroupTitleCell.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/17/26.
//

import UIKit

// MARK: - CreateQuestionCellDelegate

public protocol CreateQuestionGroupTitleCellDelegate: AnyObject {
    func createQuestionGroupTitleCell(
        _ cell: CreateQuestionGroupTitleCell,
        titleTextDidChange text: String
    )
}

public class CreateQuestionGroupTitleCell: UITableViewCell {

    // MARK: - Properties

    public weak var delegate: CreateQuestionGroupTitleCellDelegate?

    public let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Group Title"
        label.font = .preferredFont(forTextStyle: .headline)

        return label
    }()

    public let titleTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .body)

        return textField
    }()

    // MARK: - View Lifecycle

    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension CreateQuestionGroupTitleCell {
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, titleTextField,
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

extension CreateQuestionGroupTitleCell {
    @objc public func titleTextFieldDidChange(_ textField: UITextField) {
        guard let questionGroupTitle = textField.text else { return }

        delegate?.createQuestionGroupTitleCell(
            self,
            titleTextDidChange: questionGroupTitle
        )
    }
}

// MARK: - UITextFieldDelegate

extension CreateQuestionGroupTitleCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return false
    }
}
