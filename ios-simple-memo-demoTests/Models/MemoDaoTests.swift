//
//  MemoDaoTests.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_memo_demo

class MemoDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        MemoDao.deleteAll()
    }

    /// 登録できるか確認する
    func testAddMemo() {

        MemoDao.add(memo: "タイトル\n内容内容内容")
        verifyMemo(memoID: 1, title: "タイトル", description: "内容内容内容")
    }

    /// 登録できるか確認する（タイトルがないケース）
    func testAddMemo_ForNoDescription() {

        MemoDao.add(memo: "タイトル")
        verifyMemo(memoID: 1, title: "タイトル", description: "")
    }

    /// 変更できるか確認する
    func testUpdateMemo() {

        MemoDao.add(memo: "タイトル\n内容")

        let result = MemoDao.findAll().first
        result?.memo = "タイトル2\n内容内容内容内容"
        MemoDao.update(memo: result!)
        verifyMemo(memoID: 1, title: "タイトル2", description: "内容内容内容内容")
    }

    /// 削除できるか確認する
    func testDeleteMemo() {

        MemoDao.add(memo: "タイトル\n内容")
        MemoDao.delete(memoID: 1)
        verifyCount(count: 0)
    }

    /// メモが取得できるか？
    func testFindAllMemo() {

        MemoDao.add(memo: "タイトル1\n内容")
        MemoDao.add(memo: "タイトル2\n内容")
        MemoDao.add(memo: "タイトル3\n内容")
        verifyCount(count: 3)
    }

    /// メモが古い順に取得できるか？
    func testFindAllMemo_ForOrder() {

        MemoDao.add(memo: "タイトル1\n内容1")
        MemoDao.add(memo: "タイトル2\n内容2")
        MemoDao.add(memo: "タイトル3\n内容3")

        let result = MemoDao.findAll()

        XCTAssertEqual("タイトル1", result[0].loadTitle())
        XCTAssertEqual("タイトル2", result[1].loadTitle())
        XCTAssertEqual("タイトル3", result[2].loadTitle())
    }

    /// 該当のメモが取得できるか？
    func testFindByIDMemo() {

        MemoDao.add(memo: "タイトル1\n内容1")
        MemoDao.add(memo: "タイトル2\n内容2")
        MemoDao.add(memo: "タイトル3\n内容3")

        let result = MemoDao.findByID(memoID: 2)
        XCTAssertEqual("タイトル2", result?.loadTitle())
        XCTAssertEqual("内容2", result?.loadDescription())
    }

    //MARK : - Helper
    private func verifyMemo(memoID: Int, title: String, description: String) {

        let result = MemoDao.findAll()

        XCTAssertEqual(result.first?.memoID, memoID)

        if let title = result.first?.loadTitle() {
            XCTAssertEqual(title, title)
        }

        if let description = result.first?.loadDescription() {
            XCTAssertEqual(description, description)
        }

        XCTAssertNotNil(result.first?.date)
    }

    private func verifyCount(count: Int) {

        let result = MemoDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
