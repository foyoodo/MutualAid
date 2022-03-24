//
//  MAPersonalViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/20.
//

import Eureka

class MAPersonalViewController: FormViewController {

    @objc override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"

        form
        +++ Section()
        <<< TextRow() { row in
            row.title = "真实姓名"
        }
        <<< PickerInputRow<String>() {
            $0.title = "性别"
            $0.options = ["男", "女"]
            $0.value = $0.options.first
        }
        <<< DateRow() {
            $0.title = "出生日期"
            $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
        <<< EmailRow() {
            $0.title = "电子邮箱"
            $0.placeholder = "输入邮箱"
        }
        <<< PhoneRow() {
            $0.title = "联系电话"
            $0.value = "13912345678"
        }

        +++ Section()
        <<< TextRow() {
            $0.title = "家庭住址"
            $0.placeholder = "请输入详细地址"
        }
        <<< TextRow() {
            $0.title = "工作地址"
            $0.placeholder = "请输入详细地址"
        }
        <<< TextRow() {
            $0.title = "身份证号"
            $0.placeholder = "请输入身份证号"
        }

        +++ Section()
        <<< ButtonRow() {
            $0.title = "申请成为志愿者"
        }
        .onCellSelection { [weak self] cell, row in
            MAToast.showMessage("该功能暂未开放，敬请期待...", in: (self?.view)!)
        }
    }

}
