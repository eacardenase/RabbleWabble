//
//  SelectQuestionGroupController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/5/26.
//

import UIKit

public class SelectQuestionGroupController: UIViewController {

    // MARK: - Properties

    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }

    private var selectedQuestionGroup: QuestionGroup {
        get { questionGroupCaretaker.selectedQuestionGroup }
        set { questionGroupCaretaker.selectedQuestionGroup = newValue }
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

        print(AppSettings.shared.questionStrategyType)

        setupViews()

        questionGroups.forEach {
            print(
                """
                \($0.title)
                Correct Count: \($0.score.correctCount)
                Incorrect Count: \($0.score.incorrectCount)
                """
            )
        }
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

    private func setupViews() {
        view.backgroundColor = .systemBackground

        setupSettingsButton()
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
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        let questionGroup = questionGroups[indexPath.row]
        selectedQuestionGroup = questionGroup

        return indexPath
    }

    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
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

}
