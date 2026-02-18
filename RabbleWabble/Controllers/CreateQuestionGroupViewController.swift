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

    // MARK: - Properties

    public var delegate: CreateQuestionGroupViewControllerDelegate?

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

}

// MARK: - Actions

extension CreateQuestionGroupViewController {
    @objc func closeButtonTapped(_ sender: Any) {
        delegate?.createQuestionGroupViewControllerDidCancel(self)
    }

    @objc func saveButtonTapped(_ sender: Any) {
        print(#function)
    }
}

// MARK: - UITableViewDataSource

extension CreateQuestionGroupViewController {

    public override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 3
    }

    public override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let rowIndex = indexPath.row

        if rowIndex == 0 {
            return titleCell(from: tableView, for: indexPath)
        } else if rowIndex == 1 {
            return questionCell(from: tableView, for: indexPath)
        } else {
            return addQuestionGroupCell(from: tableView, for: indexPath)
        }
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

        // TODO: - Configure the cell

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

        cell.delegate = self

        // TODO: - Configure the cell

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
}

// MARK: - UITableViewDelegate

extension CreateQuestionGroupViewController {

    // TODO: - Add `UITableViewDelegate` methods

}

// MARK: - CreateQuestionCellDelegate

extension CreateQuestionGroupViewController: CreateQuestionCellDelegate {
    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        answerTextDidChange text: String
    ) {
        // TODO: - Write this
    }

    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        hintTextDidChange text: String
    ) {
        // TODO: - Write this
    }

    public func createQuestionCell(
        _ cell: CreateQuestionCell,
        promptTextDidChange text: String
    ) {
        // TODO: - Write this
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
        // TODO: - Write this
    }
}
