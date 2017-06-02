//
//  MemoListTableViewCellTests.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_memo_demo

class MemoListTableViewCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: MemoListTableViewCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "MemoListViewController", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "MemoListViewController")
            as! MemoListViewController

        _ = controller.view

        tableView = controller.tableView
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(
            withIdentifier: "MemoListTableViewCell",
            for: IndexPath(row: 0, section: 0)) as! MemoListTableViewCell

    }

    override func tearDown() {
        super.tearDown()
    }

    /// 日付は正しいか？（翌年以降）
    func testSetDateLabel_ForYYYYMMDD() {

        let memo = Memo()
        memo.memo = "タイトル\n内容"
        memo.date = string2Date(dateString: "2015/10/10 10:10:10")
        cell.memo = memo

        XCTAssertEqual(cell.dateLabel.text, "2015/10/10")
    }

    /// 日付は正しいか？（今年）
    func testSetDateLabel_ForMMDD() {

        let memo = Memo()
        memo.memo = "タイトル\n内容"
        memo.date = string2Date(dateString: "2017/01/01 10:10:10")
        cell.memo = memo
        XCTAssertEqual(cell.dateLabel.text, "01/01")
    }

    /// 日付は正しいか？（今日）
    func testSetDateLabel_ForHHMM() {

        let memo = Memo()
        memo.memo = "タイトル\n内容"
        memo.date = Date().now()
        cell.memo = memo

        let format = date2hhmmString(date:memo.date!)
        XCTAssertEqual(cell.dateLabel.text, format)
    }

    /// タイトルは正しいか？
    func testSetTitleLabel() {

        let memo = Memo()
        memo.memo = "タイトル\n内容"
        memo.date = string2Date(dateString: "2017/01/01 10:10:10")
        cell.memo = memo

        XCTAssertEqual(cell.titleLabel.text, "タイトル")
    }

    /// ディスクリプションは正しいか？
    func testSetFirstLineLabel() {

        let memo = Memo()
        memo.memo = "タイトル\n内容"
        memo.date = string2Date(dateString: "2017/01/01 10:10:10")
        cell.memo = memo

        XCTAssertEqual(cell.firstLineLabel.text, "内容")
    }

    //MARK : - Helper
    private func string2Date(dateString: String) -> Date{

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: dateString)!
    }

    private func date2hhmmString(date: Date) -> String {

        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "HH:mm"
        return dateFormater.string(from: date)
    }
}

extension MemoListTableViewCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
