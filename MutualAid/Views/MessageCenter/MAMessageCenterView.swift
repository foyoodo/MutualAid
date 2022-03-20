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
        ["进来抽奖，即得100万现金红包瓜分资格！", "许愿重磅福利来啦！仅限【2月5日】，参与放飞许愿灯活动，完成1次抽奖，即可获得瓜分100万现金大奖资格，还有机会获得SONY PS5、iPhone13等丰厚大礼，许愿抽奖戳>>>", "1个月前"],
        ["2022拜年纪开播倒计时！", "哔哩楼开张在即！2233已经张罗了一桌好菜恭候各位顾客！大家一起拭目以待吧！", "1个月前"],
        ["2022年的愿望，都来这里实现！", "放飞许愿灯活动火热进行中，来和B站的小伙伴一起许愿吧！650万份奖品，限时10天领取，先到先得，点我马上参与>>>", "1个月前"],
        ["速领！你获得了B站人专享用户奖！", "感谢2021年的关注与陪伴，特为你准备闪光用户奖！2022年也要继续一起闪闪发光哦！立即领奖>>", "1个月前"],
        ["拜年纪预约活动正式开启！", "拜年纪特色集卡活动正式开启！集卡换锦鲤，新年赢好礼！大家一起来新年转转运吧~\n预约戳>>", "1个月前"],
        ["你的B站2021年度报告来了！", "2021年，你和B站共度了多少天？哪些视频成为你的美好回忆？快来乘坐时光机，回顾你与B站的难忘瞬间吧！戳链接，开启时光旅行>>", "2个月前"]
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
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
        cell.timeLabel.text = dataArray[indexPath.row][2]
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
