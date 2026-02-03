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

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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

}
