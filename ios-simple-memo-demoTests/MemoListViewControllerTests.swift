//
//  MemoListViewControllerTests.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/06/02.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_simple_memo_demo

class MemoListViewControllerTests: XCTestCase {
    
    var controller: MemoListViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "MemoListViewController", bundle: nil)
        controller = storyboard
            .instantiateViewController(
                withIdentifier: "MemoListViewController")
            as? MemoListViewController

        _ = controller?.view
    }

    override func tearDown() {
        super.tearDown()
    }

    func testToolBarEditButton_When_Default() {
        XCTAssertEqual(controller.editButton.title, "メモ追加")
    }

    func testToolBarEditButton_When_EditModeOff() {
        controller.setEditing(false, animated: true)
        XCTAssertEqual(controller.editButton.title, "メモ追加")
    }

    func testToolBarEditButton_When_EditModeOn() {
        controller.setEditing(true, animated: true)
        XCTAssertEqual(controller.editButton.title, "すべて削除")
    }

    func testToolBarMemoCountLabel_When_Default() {
        XCTAssertEqual(controller.memoCountLabel.title, "メモなし")
    }

    func testToolBarMemoCountLabel_When_Count3() {
        controller.memoCountLabel.setMemoCount(count: 3)
        XCTAssertEqual(controller.memoCountLabel.title, "3件のメモ")
    }

    func testToolBarMemoCountLabel_When_Count_Zero() {
        controller.memoCountLabel.setMemoCount(count: 0)
        XCTAssertEqual(controller.memoCountLabel.title, "メモなし")
    }

    func testNavigationBarTitle_When_Default() {
        let title = controller.navigationItem.title
        XCTAssertEqual(title, "メモ")
    }

    func testNavigationBarEditButtonTitle_When_Default() {
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_When_EditMode_OFF() {
        controller.setEditing(false, animated: true)
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_When_EditMode_ON() {
        controller.setEditing(true, animated: true)
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "完了")
    }
}
