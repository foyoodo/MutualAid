//
//  MASettingsViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/7.
//

import Eureka

class MASettingsViewController: FormViewController {

    @objc override init(style: UITableView.Style) {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSString.init(string: "Settings").localized

        form
        +++ Section()
        <<< ButtonRow() {
            $0.title = "个人资料"
            $0.presentationMode = .show(controllerProvider: .callback(builder: {
                MAPersonalViewController.init(style: .insetGrouped)
            }), onDismiss: nil)
        }

        +++ Section()
        <<< ButtonRow() {
            $0.title = "主题设置"
            $0.presentationMode = .show(controllerProvider: .callback(builder: {
                let vc = UIViewController.init()
                vc.view.backgroundColor = .white
                return vc
            }), onDismiss: nil)
        }
        <<< LabelRow() {
            $0.title = "清理缓存"
        }

        +++ Section()
        <<< PushRow<String>() {
            $0.title = "开源软件声明"
        }
        <<< PushRow<String>() {
            $0.title = "关于"
        }

        +++ Section()
        <<< PushRow<String>() {
            $0.title = "切换账号"
        }
        <<< LabelRow() {
            $0.title = "退出登录"
        }
        .onCellSelection{ [weak self] cell, row in
            MAUserDefaults.standard().userPicUrl = ""
            MAUserDefaults.standard().userName = "未登录"
            NotificationCenter.default.post(name: .maUserLoginStateChanged, object: nil, userInfo: [
                "isLogin": false
            ])
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
