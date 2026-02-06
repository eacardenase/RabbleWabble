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
        label.text = "Test"

        return label
    }()

    public let percentageLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10%"

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

        //        contentView.addSubview(titleLabel)
        //        contentView.addSubview(percentageLabel)
        //
        //
    }

}
