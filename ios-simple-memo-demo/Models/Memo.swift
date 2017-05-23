//
//  Memo.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import RealmSwift

final class Memo: Object {

    dynamic var memoID = 0
    dynamic var memo = ""
    dynamic var date: Date?

    override static func primaryKey() -> String? {
        return "memoID"
    }

    /// タイトルを取得する(メモの一行目がタイトル)
    ///
    /// - Returns: タイトル
    func loadTitle() -> String {

        let lines = memo.components(separatedBy: "\n")
        return lines.count > 0 ? lines.first! : ""
    }

    /// 本文を取得する(メモの二行目以降が本文)
    ///
    /// - Returns: 本文
    func loadDescription() -> String {

        let lines = memo.components(separatedBy: "\n")
        let descriptions = lines.filter { !$0.isEmpty }

        return descriptions.count > 1 ? descriptions[1] : ""
    }
}
