//
//  SelectQuestionGroupController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/5/26.
//

import UIKit

public class SelectQuestionGroupController: UIViewController {

    // MARK: - Properties

    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: Question?

    internal lazy var tableView: UITableView = {
        let _tableView = UITableView()

        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(
            QuestionGroupCell.self,
            forCellReuseIdentifier: NSStringFromClass(QuestionGroupCell.self)
        )

        return _tableView
    }()

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Helpers

extension SelectQuestionGroupController {

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)

        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

// MARK: - UITableViewDataSource

extension SelectQuestionGroupController: UITableViewDataSource {

    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return questionGroups.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(QuestionGroupCell.self),
            for: indexPath
        )

        let questionGroup = questionGroups[indexPath.row]

        cell.textLabel?.text = questionGroup.title

        return cell
    }

}

// MARK: - UITableViewDelegate

extension SelectQuestionGroupController: UITableViewDelegate {

}
