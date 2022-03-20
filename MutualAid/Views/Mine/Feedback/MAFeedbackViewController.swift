//
//  MAFeedbackViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/20.
//

import Eureka

class MAFeedbackViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "意见反馈"

        form
        +++ Section()
        <<< PickerInputRow<String>() {
            $0.title = "反馈类型"
            $0.options = ["优化建议", "线上BUG", "投诉", "其他"]
        }
        <<< LabelRow() {
            $0.title = "反馈内容"
        }
        <<< TextAreaRow() {
            $0.placeholder = "请输入内容"
            $0.textAreaHeight = .dynamic(initialTextViewHeight: 120)
        }

        +++ Section()
        <<< LabelRow() {
            $0.title = "联系方式"
        }
        <<< PhoneRow() {
            $0.placeholder = "手机号"
        }
    }

}
