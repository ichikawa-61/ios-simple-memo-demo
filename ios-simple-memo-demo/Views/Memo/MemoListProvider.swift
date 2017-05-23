//
//  MemoListProvider.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol MemoListProviderDelegate: class {
    func deleteMemo(memoID: Int)
}

final class MemoListProvider: NSObject {

    fileprivate var memos: [Memo] = []
    weak var delegate: MemoListProviderDelegate?

    /// メモの一覧を設定する
    ///
    /// - Parameter memos: メモ一覧
    func setMemos(memos: [Memo]) {
        self.memos = memos
    }

    /// 該当のメモを取得する
    ///
    /// - Parameter index: TableViewのインデックス
    /// - Returns: メモ
    func memo(index: Int) -> Memo {

        guard index < memos.count else {
            fatalError("memosの要素数を超えました。")
        }
        return memos[index]
    }

    /// メモの数を取得する
    ///
    /// - Returns: メモ数
    func count() -> Int {
        return memos.count
    }
}

//MARK : -UITableViewDataSource
extension MemoListProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView
            .dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier,
                                 for: indexPath) as? MemoListTableViewCell
        cell?.memo = memo(index: indexPath.row)
        return cell!
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == UITableViewCellEditingStyle.delete {

            let momo = memo(index: indexPath.row)
            memos.remove(at: indexPath.row)
            delegate?.deleteMemo(memoID: momo.memoID)
        }
    }
}
