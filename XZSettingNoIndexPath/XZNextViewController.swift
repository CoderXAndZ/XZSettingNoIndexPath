//
//  XZNextViewController.swift
//  XZSettingNoIndexPath
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class XZNextViewController: UIViewController {
    
    var action: (() -> Void)?
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        action?()
    }
    
}
