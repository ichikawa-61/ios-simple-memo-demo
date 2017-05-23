//
//  MemoDao.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import RealmSwift
import STV_Extensions

final class MemoDao {

    static let dao = RealmDaoHelper<Memo>()

    /// メモを登録する
    ///
    /// - Parameters:
    ///   - folderID: フォルダID
    ///   - memo:  メモ
    static func add(folderID: Int, memo: String) {

        let object = Memo()
        object.memoID = MemoDao.dao.newId()!
        object.memo = memo
        object.date = Date().now()
        MemoDao.dao.add(data: object)
    }

    /// メモを更新する
    ///
    /// - Parameter memo: メモ
    static func update(memo: Memo) {

        guard let target = dao
            .findFirst(key: memo.memoID as AnyObject) else {
                return
        }

        let object = Memo()
        object.memoID = target.memoID
        object.memo = memo.memo
        object.date = Date().now()
        _ = dao.update(data: object)
    }

    /// メモを削除する
    ///
    /// - Parameter memoID: メモID
    static func delete(memoID: Int) {

        guard let target = dao
            .findFirst(key: memoID as AnyObject) else {
                return
        }
        dao.delete(data: target)
    }

    /// メモをすべて削除する
    static func deleteAll() {
        dao.deleteAll()
    }

    /// 該当のメモを取得する
    ///
    /// - Parameter memoID: メモID
    /// - Returns: メモ
    static func findByID(memoID: Int) -> Memo? {
        guard let object = dao
            .findFirst(key: memoID as AnyObject) else {
                return nil
        }
        return object
    }

    /// すべてのメモを取得する
    ///
    /// - Returns: メモ一覧
    static func findAll() -> [Memo] {
        let objects = MemoDao.dao
            .findAll()
            .sorted(byKeyPath: "date", ascending: false)
        return objects.map { Memo(value: $0) }
    }
}

