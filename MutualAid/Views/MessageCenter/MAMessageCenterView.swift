//
//  MAMessageCenterView.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/1.
//

import UIKit

class MAMessageCenterView: UIView, UITableViewDataSource {

    var array: Array<String> = [
        "1", "2", "3", "4", "5"
    ]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.addSubview(self.tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        if self.tableView.frame.equalTo(.zero) {
            self.tableView.frame = self.bounds
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "id") else {
            return .init(style: .subtitle, reuseIdentifier: "id")
        }
        return cell
    }

}

extension MAMessageCenterView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }

}
