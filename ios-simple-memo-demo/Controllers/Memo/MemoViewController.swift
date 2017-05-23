//
//  MemoViewController.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import STV_Extensions
import UIKit

final class MemoViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    private var memo: Memo?
    
    /// メモ登録画面のインスタンスを取得する
    ///
    /// - Returns: メモ登録画面のインスタンス
    static func configuredWith() -> MemoViewController {
        
        let vc = UIStoryboard
            .viewController(className: MemoViewController.className) as? MemoViewController
        return vc!
    }
    
    /// メモ変更画面のインスタンスを取得する
    ///
    /// - Parameter memo: メモ
    /// - Returns: メモ変更画面のインスタンスを取得する
    static func configuredWith(memo: Memo) -> MemoViewController {
        
        let vc = UIStoryboard
            .viewController(className: MemoViewController.className) as? MemoViewController
        vc?.memo = memo
        return vc!
    }

    //MARK : -　LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tearDown()
    }
    
    //MARK : - Action
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        
        if !textView.text.isEmpty {
            
            if let memo = self.memo {
                
                let lastMemo = memo
                lastMemo.memo = textView.text
                MemoDao.update(memo: lastMemo)
                
            } else {
                MemoDao.add(memo: textView.text)
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK : - Private
    /// 初期化
    private func setup() {
        setupTextView()
    }
    
    /// 事後処理
    private func tearDown() {
        hideKeyboard()
    }
    
    /// メモ入力/表示用のテキストビューを設定する
    private func setupTextView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let memo = self.memo {
            textView.text = memo.memo
        }
    }
    
    /// キーボードを表示する
    private func showKeyboard() {
        textView.becomeFirstResponder()
    }
    
    /// キーボードを消す
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
}
