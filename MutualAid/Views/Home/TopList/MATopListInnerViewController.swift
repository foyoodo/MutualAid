//
//  MATopListInnerViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/18.
//

import UIKit
import SnapKit

class MATopListInnerViewController: UIViewController {

    var dataArray: Array<MAPicListModel>
    var detailDataArray: Array<MATopListDetailModel>

    convenience init() {
        self.init(dataArray: [], detailDataArray: [])
    }

    @objc init(dataArray: Array<MAPicListModel>, detailDataArray: Array<MATopListDetailModel>) {
        self.dataArray = dataArray
        self.detailDataArray = detailDataArray
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.register(UINib.init(nibName: "MATopListInnerCell", bundle: nil), forCellReuseIdentifier: "MATopListInnerCell")
        return tableView
    }();

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension MATopListInnerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let vc: MATopListDetailViewController = MATopListDetailViewController.init(detailDataArray[indexPath.row])
        vc.title = self.dataArray[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension MATopListInnerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MATopListInnerCell", for: indexPath) as! MATopListInnerCell
        cell.iconView.yy_imageURL = URL.init(string: dataArray[indexPath.row].picUrl)
        cell.titleLabel.text = dataArray[indexPath.row].title
        return cell
    }

}
