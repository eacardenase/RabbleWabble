//
//  AppSettingsController.swift
//  RabbleWabble
//
//  Created by Edwin Cardenas on 2/9/26.
//

import UIKit

public class AppSettingsController: UITableViewController {

    // MARK: - Properties

    public let appSettings = AppSettings.shared

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "App Settings"

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )
    }

}

// MARK: - UITableViewDataSource

extension AppSettingsController {

    public override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return QuestionStrategyType.allCases.count
    }

    public override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]

        var cellConfiguration = UIListContentConfiguration.cell()
        cellConfiguration.text = questionStrategyType.title

        cell.contentConfiguration = cellConfiguration

        if appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

}

// MARK: - UITableViewDelegate

extension AppSettingsController {

    public override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]

        appSettings.questionStrategyType = questionStrategyType

        tableView.reloadData()
    }

}
