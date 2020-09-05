
import UIKit
//import SwiftMessages
import Toast_Swift
class AXModel:NSObject{
    
}
class AXToastManager: AXModel {

    static let shared:AXToastManager = AXToastManager()
    var style = ToastStyle()
    var isToastDisplay:Bool = false
    override init() {
        super.init()
        
        
        // this is just one of many style options
        style.messageColor = .white
       
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true
        
        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = true
        
        ToastManager.shared.style = style
        ToastManager.shared.duration = 1.0
    
    }
    func showSuccessMessage(withMessage message:String){
//        let success = MessageView.viewFromNib(layout: .cardView)
//        success.configureTheme(.success)
//        success.configureDropShadow()
//        success.configureContent(title: Constant.App.Name, body: message)
//        success.button?.isHidden = true
//        var successConfig = SwiftMessages.defaultConfig
//        successConfig.presentationStyle = .center
//        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
//
//
//        SwiftMessages.show(config: successConfig, view: success)
        if  let application:AppDelegate = UIApplication.shared.delegate as? AppDelegate, let window = application.window {
            window.makeToast(message)
        }
    }
    func showErrorMessage(withMessage message:String){
//        let info = MessageView.viewFromNib(layout: .messageView)
//        info.configureTheme(.error)
//        info.button?.isHidden = true
//        info.configureContent(title: "Error", body: message)
//        var infoConfig = SwiftMessages.defaultConfig
//        infoConfig.presentationStyle = .bottom
//        infoConfig.duration = .seconds(seconds: 1.0)
//
//        SwiftMessages.show(config: infoConfig, view: info)
        
        
//        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
//            window.makeToast(message)
//        }
    }
    func showInternetConnectionMessage(withMessage message:String){
          
        if let application:AppDelegate = UIApplication.shared.delegate as? AppDelegate, let window = application.window {
                if isToastDisplay == false {
                    isToastDisplay = true
                    window.makeToast(message, duration: 1.0, point: CGPoint.init(x: 50, y: UIScreen.main.bounds.height - 90), title: nil, image: nil, style: ToastStyle()) { (success) in
                        self.isToastDisplay = false
                    }
                    
                }
                
            }
        
        }
    
}
