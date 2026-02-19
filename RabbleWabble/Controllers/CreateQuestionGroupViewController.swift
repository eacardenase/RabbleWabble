//
//  CreateQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/17/26.
//

import UIKit

public protocol CreateQuestionGroupViewControllerDelegate {

    func createQuestionGroupViewControllerDidCancel(
        _ viewController: CreateQuestionGroupViewController
    )

    func createQuestionGroupViewController(
        _ viewController: CreateQuestionGroupViewController,
        created questionGroup: QuestionGroup
    )
}

public class CreateQuestionGroupViewController: UITableViewController {

    public enum QuestionGroupSections: Int, CaseIterable {
        case groupTitle
        case groupQuestions
        case addNewGroupQuestion
    }

    // MARK: - Properties

    public var delegate: CreateQuestionGroupViewControllerDelegate?
    public let questionGroupBuilder = QuestionGroupBuilder()

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        tableView.separatorStyle = .none
        tableView.register(
            CreateQuestionGroupTitleCell.self,
            forCellReuseIdentifier: NSStringFromClass(
                CreateQuestionGroupTitleCell.self
            )
        )
        tableView.register(
            CreateQuestionCell.self,
            forCellReuseIdentifier: NSStringFromClass(CreateQuestionCell.self)
        )
        tableView.register(
            AddQuestionCell.self,
            forCellReuseIdentifier: NSStringFromClass(AddQuestionCell.self)
        )
    }
}

// MARK: - Helpers

extension CreateQuestionGroupViewController {

    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
    }

    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }

    private func setupViews() {
        title = "New Question Group"

        setupCloseButton()
        setupSaveButton()
    }

    private func questionBuilder(for indexPath: IndexPath) -> QuestionBuilder {
        return questionGroupBuilder.questions[indexPath.row]
    }

    private func questionBuilder(for cell: CreateQuestionCell)
        -> QuestionBuilder?
    {
        guard let indexPath = tableView.indexPath(for: cell) else { return nil }

        return questionBuilder(for: indexPath)
    }

    private func titleCell(
        from tableView: UITableView,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(
                    CreateQuestionGroupTitleCell.self
                ),
                for: indexPath
            ) as? CreateQuestionGroupTitleCell
        else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.titleTextField.text = questionGroupBuilder.title

        return cell
    }

    private func questionCell(
        from tableView: UITableView,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: NSStringFromClass(CreateQuestionCell.self),
                    for: indexPath
                ) as? CreateQuestionCell
        else {
            return UITableViewCell()
        }

        let questionBuilder = questionBuilder(for: indexPath)

        cell.delegate = self
        cell.indexLabel.text = "Question \(indexPath.row + 1)"
        cell.answerTextField.text = questionBuilder.answer
        cell.hintTextField.text = questionBuilder.hint
        cell.promptTextField.text = questionBuilder.prompt

        return cell
    }

    private func addQuestionGroupCell(
        from tableView: UITableView,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(AddQuestionCell.self),
            for: indexPath
        )
    }

    private func displayMissingInputsAlert() {
        let alert = UIAlertController(
            title: "Missing Inputs",
            message: "Please provide all non-optional values",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "Ok", style: .default)

        alert.addAction(okAction)

        present(alert, animated: true)
    }
}

// MARK: - Actions

extension CreateQuestionGroupViewController {
    @objc func closeButtonTapped(_ sender: Any) {
        delegate?.createQuestionGroupViewControllerDidCancel(self)
    }

    @objc func saveButtonTapped(_ sender: Any) {
        do {
            let questionGroup = try questionGroupBuilder.build()

            delegate?.createQuestionGroupViewController(
                self,
                created: questionGroup
            )
        } catch {
            displayMissingInputsAlert()
        }
    }
}

// MARK: - UITableViewDataSource

extension CreateQuestionGroupViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return QuestionGroupSections.allCases.count
    }

    public override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = QuestionGroupSections.allCases[section]

        switch section {
        case .groupTitle:
            return 1
        case .groupQuestions:
            return questionGroupBuilder.questions.count
        case .addNewGroupQuestion:
            return 1
        }
    }

    public override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let section = QuestionGroupSections.allCases[indexPath.section]

        switch section {
        case .groupTitle:
            return titleCell(from: tableView, for: indexPath)
        case .groupQuestions:
            return questionCell(from: tableView, for: indexPath)
        case .addNewGroupQuestion:
            return addQuestionGroupCell(from: tableView, for: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate

extension CreateQuestionGroupViewController {

    public override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let section = QuestionGroupSections.allCases[indexPath.section]
        let newQuestionIndex = tableView.numberOfRows(
            inSection: QuestionGroupSections.groupQuestions.rawValue
        )

        let newIndexPath = IndexPath(
            row: newQuestionIndex,
            section: QuestionGroupSections.groupQuestions.rawValue
        )

        if case .addNewGroupQuestion = section {
            questionGroupBuilder.addNewQuestion()

            tableView.insertRows(at: [newIndexPath], with: .top)
        }
    }

}

// MARK: - CreateQuestionCellDelegate

extension CreateQuestionGroupViewController: CreateQuestionCellDelegate {
    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        answerTextDidChange text: String
    ) {
        guard let questionBuilder = questionBuilder(for: cell) else { return }

        questionBuilder.answer = text
    }

    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        hintTextDidChange text: String
    ) {
        guard let questionBuilder = questionBuilder(for: cell) else { return }

        questionBuilder.hint = text
    }

    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        promptTextDidChange text: String
    ) {
        guard let questionBuilder = questionBuilder(for: cell) else { return }

        questionBuilder.prompt = text
    }
}

// MARK: - CreateQuestionGroupTitleCellDelegate

extension CreateQuestionGroupViewController:
    CreateQuestionGroupTitleCellDelegate
{
    public func createQuestionGroupTitleCell(
        _ cell: CreateQuestionGroupTitleCell,
        titleTextDidChange text: String
    ) {
        questionGroupBuilder.title = text
    }
}
