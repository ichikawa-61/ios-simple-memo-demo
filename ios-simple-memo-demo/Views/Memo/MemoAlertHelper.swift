//
//  MemoAlertHelper.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol MemoAlertHelperDelegate: class {
    func deleteAll()
}

final class MemoAlertHelper: NSObject {

    weak var delegate: MemoAlertHelperDelegate?
    private var alert: UIAlertController!

    /// メモ削除用ダイアログの作成
    ///
    /// - Parameters:
    ///   - delegate: 完了通知用のデリゲード
    /// - Returns: UIAlertViewControllerのインスタンス
    func deleteMemo(delegate: MemoAlertHelperDelegate) -> UIAlertController {

        alert = UIAlertController(title: nil,
                                  message: nil,
                                  preferredStyle: .actionSheet)

        self.delegate = delegate

        let cancelAction = UIAlertAction(title: Constrains.Alert.cancelButton,
                                         style: .cancel,
                                         handler: nil)

        let deleteAction = UIAlertAction(title: Constrains.Alert.deleteAllButton,
                                         style: .destructive) { _ in
                                            self.delegate?.deleteAll()
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        return alert
    }
}

