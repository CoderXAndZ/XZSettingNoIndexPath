//
//  XZTableViewController.swift
//  XZSettingNoIndexPath
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

final class XZTableViewController: UITableViewController {

    //
    let list:[[Item]] = [
        [.security],
        [.notification, .privacy, .general],
        [.help, .aboutUs],
        [.plugin],
        [.changeAccount],
        [.logout]
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let blueVC = segue.destination as? XZNextViewController {
            blueVC.action = { [weak self] in
                self?.performSegue(withIdentifier: "ShowRed", sender: nil)
            }
        }
    }
}

// MARK: - Table view data source
extension XZTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        
        cell.accessoryType = item.accessoryType
        
        if let cell = cell as? XZTableViewImageCell {
            cell.labelTitle.text = item.title
            
            return cell
        }
        
        cell.textLabel?.text = item.title
        
        if item.style == .detail {
            cell.detailTextLabel?.text = item.detail
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {   return .leastNormalMagnitude }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 设置数据
extension XZTableViewController {
    
    enum Item { /// 整个tableView的每一行的标识
        case security, notification, privacy, general, help, aboutUs, plugin, changeAccount, logout
        
        enum Style { /// cell的样式
            case title, detail, image, accessory, centered
            
            var identifier : String {
                switch self {
                case .title: return "TitleCell"
                case .detail: return "DetailCell"
                case .image: return "ImageCell"
                case .accessory: return "AccessoryCell"
                case .centered: return "CenteredTitleCell"
                }
            }
        }
        
        var style : Style {
            switch self {
            case .aboutUs: return .detail
            case .plugin: return .image
            case .notification: return .accessory
            case .changeAccount, .logout: return .centered
            default: return .title
            }
        }
        
        var identifier : String {
            return style.identifier
        }
        
        var title : String? {
            switch self {
            case .security:     return "帐号与安全"
            case .notification: return "新消息通知"
            case .privacy:      return "隐私"
            case .general:      return "通用"
            case .help:     return "帮助与反馈"
            case .aboutUs:     return "关于微信"
            case .plugin:     return "插件"
            case .changeAccount:     return "切换帐号"
            case .logout:     return "退出登录"
            }
        }
        
        var detail : String? {
            switch self {
            case .aboutUs:
                return "版本" + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
            default:
                return nil
            }
        }
        
        var accessoryType : UITableViewCellAccessoryType {
            switch style {
            case .centered: return .none
            default:        return .disclosureIndicator
            }
        }
        
    }
}

// MARK: - XZTableViewImageCell
final class XZTableViewImageCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var imageViewSub: UIImageView!
}

// MARK: - XZTableViewImageCell
final class XZRedSegue: UIStoryboardSegue {
    
    override func perform() {
        guard let navigationController = source.navigationController,
            navigationController.topViewController is XZNextViewController
        else {
            super.perform()
            return
        }
        
        
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(destination)
        navigationController.setViewControllers(viewControllers, animated: true)
        
    }
    
}
