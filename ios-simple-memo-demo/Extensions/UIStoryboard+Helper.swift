//
//  UIStoryboard+Helper.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import STV_Extensions
import UIKit

extension UIStoryboard {

    /// ViewControllerのインスタンスを取得する
    ///
    /// - Parameter className: クラス名
    /// - Returns: ViewControllerのインスタンス
    static func viewController(className: String) -> UIViewController {
        return UIStoryboard.viewController(storyboardName: className,
                                           identifier: className)!
    }
}
