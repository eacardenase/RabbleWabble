//
//  SelectQuestionGroupController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/5/26.
//

import Combine
import UIKit

public class SelectQuestionGroupController: UIViewController {

    // MARK: - Properties

    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }

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

    private func setupSettingsButton() {
        let image = UIImage(resource: .icSettings)

        navigationItem.leftBarButtonItem =
            UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(settingsButtonTapped)
            )
    }

    private func setupAddQuestionGroupButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addQuestionGroupButtonTapped)
        )
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground

        setupSettingsButton()
        setupAddQuestionGroupButton()
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
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(QuestionGroupCell.self),
                for: indexPath
            ) as? QuestionGroupCell
        else {
            return UITableViewCell()
        }

        let questionGroup = questionGroups[indexPath.row]

        let publisher = questionGroup.score.$runningPercentage
        let subscriber = publisher.receive(on: OperationQueue.main)
            .map { String(format: "%.0f %%", $0) }
            .assign(to: \.text, on: cell.percentageLabel)

        cell.titleLabel.text = questionGroup.title
        cell.percentageSubscriber = subscriber

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
        questionGroupCaretaker.selectedQuestionGroup = questionGroup

        let questionStrategy = AppSettings.shared.questionStrategy(
            for: questionGroupCaretaker
        )

        let controller = QuestionController(questionStrategy: questionStrategy)
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

// MARK: - Actions

extension SelectQuestionGroupController {

    @objc public func settingsButtonTapped(_ sender: UIBarButtonItem) {
        let viewController = AppSettingsController()

        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc public func addQuestionGroupButtonTapped(_ sender: UIBarButtonItem) {
        let viewController = CreateQuestionGroupViewController()
        viewController.delegate = self

        let navigationController = UINavigationController(
            rootViewController: viewController
        )

        present(navigationController, animated: true)
    }

}

// MARK: - CreateQuestionGroupViewControllerDelegate

extension SelectQuestionGroupController:
    CreateQuestionGroupViewControllerDelegate
{
    public func createQuestionGroupViewControllerDidCancel(
        _ viewController: CreateQuestionGroupViewController
    ) {
        viewController.dismiss(animated: true)
    }

    public func createQuestionGroupViewController(
        _ viewController: CreateQuestionGroupViewController,
        created questionGroup: QuestionGroup
    ) {
        questionGroupCaretaker.questionGroups.append(questionGroup)

        try? questionGroupCaretaker.save()

        viewController.dismiss(animated: true)

        tableView.reloadData()
    }

}
