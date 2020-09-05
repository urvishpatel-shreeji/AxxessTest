//
//  AXAlertView.swift
//  AxxessTest
//
//  Created by Urvish Patel on 05/09/2020.
//  Copyright © 2019 Urvish Patel. All rights reserved.
//

import UIKit

class AXAlertView: NSObject {
    
    static func showAlert(withType type:UIAlertController.Style,withMessage message:String,withButtons buttons:[String],withCompletion completion:((Int)->Void)?){
        
        let alertView:UIAlertController = UIAlertController.init(title: "AxxessTest", message: message, preferredStyle: type)
        
        for i in 0..<buttons.count{
            let title:String = buttons[i]
            var actionType:UIAlertAction.Style = .default
            if title.lowercased() == "cancel"{
                actionType = .cancel
            }
            else{
                actionType = .default
            }
            let action:UIAlertAction = UIAlertAction.init(title: title, style: actionType) { (action) in
                if let handler = completion{
                    handler(i)
                }
            }
            alertView.addAction(action)
        }
        if Device.isIpad{
           
          if let popoverPresentationController = alertView.popoverPresentationController {
            if let view:UIView =  UIViewController.topViewController()?.view as? UIView {
                popoverPresentationController.sourceView = view
                popoverPresentationController.sourceRect = CGRect.init(x: view.bounds.size.width / 2.0, y: view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
            }
                 UIViewController.topViewController()?.present(alertView, animated: true, completion: nil)
            }
            
        }else{
           UIViewController.topViewController()?.present(alertView, animated: true, completion: nil)
        }
        
    }
}

extension UIViewController{
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}
class Device: NSObject {
    
    internal enum DeviceType{
        case iphone4
        case iphone5
        case iphone6
        case iphone6Plus
        case iphoneX
        case iphoneXSMax
        case ipad
    }
    static let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    
    class var deviceType:DeviceType {
        switch UIScreen.main.bounds.size.height{
        case 420:
            return .iphone4
        case 568:
            return .iphone5
        case 667:
            return .iphone6
        case 736:
            return .iphone6Plus
        case 812:
            return .iphoneX
        case 896:
            return .iphoneXSMax
        default:
            return .iphoneX
        }
    }
    
    static var isIpad:Bool{
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        }
        else
        {
            return true
            
        }
    }
    
}
extension UIDevice{
    var getSpacing: CGFloat!{
        switch UIScreen.main.scale {
        case 1:
            return 8
        case 2:
            return 16
        case 3:
            return 20
        default:
            return 16
        }
    }
    var getAppStandartSpacing:CGFloat!{
        return self.getSpacing * 0.8
    }
}
