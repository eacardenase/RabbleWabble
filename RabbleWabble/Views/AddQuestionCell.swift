//
//  AddQuestionCell.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/17/26.
//

import UIKit

public class AddQuestionCell: UITableViewCell {

    // MARK: - Properties

    private let addQuestionImageView: UIImageView = {
        let image = UIImage(resource: .icCirclePlus)
        let imageView = UIImageView(image: image)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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

extension AddQuestionCell {

    private func setupViews() {
        contentView.addSubview(addQuestionImageView)

        // addQuestionImageView
        NSLayoutConstraint.activate([
            addQuestionImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            addQuestionImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
            addQuestionImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
        ])
    }

}
