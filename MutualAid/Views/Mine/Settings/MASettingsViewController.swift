//
//  MASettingsViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/7.
//

import UIKit
import SnapKit

class MASettingsViewController: UIViewController {
    var dataArray: Array = [
        ["个人资料"],
        ["主题设置", "清理缓存"],
        ["开源软件声明", "关于"],
        ["切换账号", "退出登录"]
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.title = NSString.init(string: "Settings").localized
    }
}

extension MASettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MASettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataArray[indexPath.section][indexPath.row]

        if indexPath.section == 1 && indexPath.item == 1 {
            cell.accessoryType = .none
        }

        if indexPath.section == dataArray.count - 1 && indexPath.item == dataArray.last!.count - 1 {
            cell.accessoryType = .none
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return .init(frame: .init(x: 0, y: 0, width: 0, height: 20))
    }
}
