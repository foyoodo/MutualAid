//
//  MAMessageCenterCell.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/20.
//

import UIKit

class MAMessageCenterCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
