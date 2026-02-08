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

    public override func loadView() {
        self.view = tableView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Question Group"

        setupViews()
    }

}

// MARK: - Helpers

extension SelectQuestionGroupController {

    private func setupViews() {
        view.backgroundColor = .systemBackground
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

    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let questionGroup = questionGroups[indexPath.row]
        let randomStrategy = RandomQuestionStrategy(
            questionGroup: questionGroup
        )
        let controller = QuestionController(questionStrategy: randomStrategy)

        controller.delegate = self

        navigationController?.pushViewController(controller, animated: true)
    }

}

// MARK: - QuestionControllerDelegate

extension SelectQuestionGroupController: QuestionControllerDelegate {

    public func questionController(
        _ controller: QuestionController,
        didCancel questionStraregy: QuestionStrategy
    ) {
        navigationController?.popToViewController(self, animated: true)
    }

    public func questionController(
        _ controller: QuestionController,
        didComplete questionStrategy: QuestionStrategy
    ) {
        navigationController?.popToViewController(self, animated: true)
    }

}
