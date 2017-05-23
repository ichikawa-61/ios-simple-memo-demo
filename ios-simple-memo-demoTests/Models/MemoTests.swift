//
//  MemoTests.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_memo_demo

class MemoTests: XCTestCase {

    let memo = Memo()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    /// メモが設定できるか？
    func testSetMemo() {

        memo.memoID = 1
        memo.memo = "タイトル\n内容"
        memo.date = string2Date(dateString: "2017/10/10")

        verifyMemo(memoID: 1, title: "タイトル", description: "内容",
                   dateString: "2017/10/10")
    }

    /// メモが設定できるか？(ディスクリプションなし）
    func testSetMemo_NoDescription() {

        memo.memoID = 1
        memo.memo = "タイトル"
        memo.date = string2Date(dateString: "2017/12/12")

        verifyMemo(memoID: 1,
                   title: "タイトル",
                   description: "",
                   dateString: "2017/12/12")
    }

    /// メモが設定できるか？（タイトル&ディスクリプションなし）
    func testSetMemo_NoTitleAndDescription() {

        memo.memoID = 1
        memo.date = string2Date(dateString: "2017/01/01")

        verifyMemo(memoID: 1,
                   title: "",
                   description: "",
                   dateString: "2017/01/01")
    }

    //MARK : - Helper
    private func verifyMemo(memoID: Int,
                            title: String,
                            description: String,
                            dateString: String) {

        XCTAssertEqual(memo.memoID, memoID)
        XCTAssertEqual(title, memo.loadTitle())
        XCTAssertEqual(description, memo.loadDescription())
        XCTAssertEqual(dateString, date2String(date: memo.date!))
    }

    private func string2Date(dateString: String) -> Date{

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString)!
    }

    private func date2String(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd"
        return dateFormater.string(from: date)
    }
}
