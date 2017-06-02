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

    func testDefault_ForEditButton() {
        XCTAssertEqual(controller.editButton.title, "メモ追加")
    }

    func testNormalMode_ForEditButton() {
        controller.setEditing(false, animated: true)
        XCTAssertEqual(controller.editButton.title, "メモ追加")
    }

    func testEditMode_ForEditButton() {
        controller.setEditing(true, animated: true)
        XCTAssertEqual(controller.editButton.title, "すべて削除")
    }

    func testMemoCountLabel_Default() {
        XCTAssertEqual(controller.memoCountLabel.title, "メモなし")
    }

    func testMemoCountLabel_3Count() {
        controller.memoCountLabel.setMemoCount(count: 3)
        XCTAssertEqual(controller.memoCountLabel.title, "3件のメモ")
    }

    func testMemoCountLabel_ZeroCount() {
        controller.memoCountLabel.setMemoCount(count: 0)
        XCTAssertEqual(controller.memoCountLabel.title, "メモなし")
    }

    func testNavigationBarTitle() {
        let title = controller.navigationItem.title
        XCTAssertEqual(title, "メモ")
    }

    func testNavigationBarEditButtonTitle_Edit() {
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "編集")
    }

    func testNavigationBarEditButtonTitle_Complate() {
        controller.setEditing(true, animated: true)
        let title = controller.navigationItem.rightBarButtonItem?.title
        XCTAssertEqual(title, "完了")
    }}
