//
//  UIBarButtonItem.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    /// メモの件数を設定する
    ///
    /// - Parameter count: <#count description#>
    func setMemoCount(count: Int) {
        self.title = count == 0 ? "メモなし" : "\(count)件のメモ"
    }
}

