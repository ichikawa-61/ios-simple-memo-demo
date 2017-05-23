//
//  MemoListViewController.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import STV_Extensions
import UIKit

final class MemoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!    
    @IBOutlet weak var memoCountLabel: UIBarButtonItem!
    
    fileprivate let dataSource = MemoListProvider()
    private var alert: UIAlertController!

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMemoList()
        updateMemoCount()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateMemoCount()
    }
    
    //MARK : - Action
    @IBAction func didTapEditMemo(_ sender: UIBarButtonItem) {
        
        if isEditing {
            showAllDeleteMemoAlert()
            
        } else {
            showNewMemoViewController()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {

        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        setupEditButton(isEditing: editing)
    }
    
    //MARK : - FilePrivate
    /// メモ一覧を取得する
    fileprivate func reloadMemoList() {

        let memos = MemoDao.findAll()
        dataSource.setMemos(memos: memos)
        tableView.reloadData()
    }
    
    /// メモ件数を設定する
    fileprivate func updateMemoCount() {
        
        let memoCount = dataSource.count()
        memoCountLabel.setMemoCount(count: memoCount)
    }

    //MARK : - Private
    /// 初期化
    private func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    /// ナビゲーションバーを設定する
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    /// テーブルビューを設定する
    private func setupTableView() {
        dataSource.delegate = self        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
    }

    /// 編集ボタンのタイトルを設定する
    ///
    /// - Parameter isEditing: 編集モード
    private func setupEditButton(isEditing: Bool) {
        editButton.title = isEditing ?
            Constrains.ToolBar.deleteAllButton :
            Constrains.ToolBar.addMemoButton
    }
    
    /// メモ画面を表示する
    private func showNewMemoViewController() {
        
        let vc = MemoViewController.configuredWith()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 全メモ削除用のアラートを表示する
    private func showAllDeleteMemoAlert() {
        
        alert = MemoAlertHelper()
            .deleteMemo(delegate: self)
        present(alert, animated: true, completion: {
            self.alert = nil
        })
    }
}

//MARK : - UITableViewDelegate
extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isEditing { return }
        
        let memo = dataSource.memo(index: indexPath.row)
        let vc = MemoViewController.configuredWith(memo: memo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK : - MemoListProviderDelegate
extension MemoListViewController: MemoListProviderDelegate {
    
    /// メモを削除する
    ///
    /// - Parameter memoID: メモID
    func deleteMemo(memoID: Int) {
        MemoDao.delete(memoID: memoID)
        updateMemoCount()
        tableView.reloadData()
    }
}

//MARK : - MemoAlertHelperDelegate
extension MemoListViewController: MemoAlertHelperDelegate {
    
    /// メモをすべて削除する
    ///
    /// - Parameter folderID: フォルダID
    func deleteAll() {
        MemoDao.deleteAll()
        reloadMemoList()
        updateMemoCount()
        tableView.reloadData()
    }
}
