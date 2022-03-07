//
//  MASettingsViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/7.
//

import UIKit
import SnapKit

class MASettingsViewController: UIViewController, UITableViewDataSource {

    lazy var dataArray: Array<String> = [
        "0", "1", "2", "3", "4"
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ma_prefersTabBarHidden = true

        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        self.title = NSString.init(string: "Settings").localized
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

}
