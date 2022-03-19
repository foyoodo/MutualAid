//
//  MATopListDetailSegmentView.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/19.
//

import UIKit
import SnapKit

class MATopListDetailSegmentView: UIView {

    let titleButton: UIButton = {
        let titleButton = UIButton()
        titleButton.setAttributedTitle(NSAttributedString.init(string: "课程介绍", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]), for: .normal)
        return titleButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-6)
        }
    }

}
