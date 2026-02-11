//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/5/26.
//

import UIKit

public class QuestionGroupCell: UITableViewCell {

    // MARK: - Properties

    public let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    public let percentageLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    // MARK: - Initializers

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

extension QuestionGroupCell {

    private func setupViews() {
        backgroundColor = .systemBackground

        contentView.addSubview(titleLabel)
        contentView.addSubview(percentageLabel)

        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: percentageLabel.leadingAnchor,
                constant: 8
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
        ])

        // percentageLabel
        NSLayoutConstraint.activate([
            percentageLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            percentageLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            percentageLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
        ])
    }

}
