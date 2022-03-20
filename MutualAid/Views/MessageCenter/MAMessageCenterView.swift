//
//  MAMessageCenterView.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/1.
//

import UIKit
import SnapKit

class MAMessageCenterView: UIView, UITableViewDataSource {

    var dataArray: Array<Array<String>> = [
        ["未关注人的消息", "暂无未关注人的消息"],
        ["进来抽奖，即得100万现金红包瓜分资格！", "许愿重磅福利来啦！"],
        ["2022拜年纪开播倒计时！", "哔哩楼开张在即！2233已经张罗了一桌好菜恭候各位顾客！大家一起拭目以待吧！"]
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 64
        tableView.register(UINib.init(nibName: "MAMessageCenterCell", bundle: nil), forCellReuseIdentifier: "MAMessageCenterCell")
        return tableView
    }()

    let swipeActionsConfiguration: UISwipeActionsConfiguration = {
        let actionRead = UIContextualAction(style: .normal, title: "已读") { (action, view, completionHandler) in
            view.backgroundColor = .init(named: "AccentColor")
            completionHandler(true)
        }
        let actionDelete = UIContextualAction(style: .destructive, title: "删除") { (action, view, completionHandler) in
            completionHandler(true)
        }
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [actionRead, actionDelete])
        return swipeActionsConfiguration
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.delegate = self
        tableView.dataSource = self

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MAMessageCenterCell", for: indexPath) as! MAMessageCenterCell
        cell.titleLabel.text = dataArray[indexPath.row][0]
        cell.detailLabel.text = dataArray[indexPath.row][1]
        return cell
    }

}

extension MAMessageCenterView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return swipeActionsConfiguration
    }

}
