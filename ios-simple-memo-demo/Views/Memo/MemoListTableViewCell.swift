//
//  MemoListTableViewCell.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import STV_Extensions

final class MemoListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var firstLineLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    /// メモ
    var memo: Memo? {

        didSet {

            titleLabel.text = memo?.loadTitle()
            firstLineLabel.text = memo?.loadDescription()

            if let date = memo?.date {
                dateLabel.text = date.dateStyle()
            }
        }
    }
}
