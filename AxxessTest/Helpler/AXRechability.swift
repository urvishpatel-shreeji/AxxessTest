//
//  AXRechability.swift
//  Oozee
//
//  Created by Urvish Patel on 05/09/2020.
//  Copyright © 2020 Urvish Patel. All rights reserved.
//

import UIKit
import Reachability

enum NetworkStatus{
    case none
    case disconnected
    case connectedViaWifi
    case connectedViaCellular
}
class AXRechability: NSObject {

    static let shared:AXRechability = AXRechability()
    var didReceiveNotification:((NetworkStatus)->Void)?
    var networkStatus:NetworkStatus = .none
    private override init() {
        super.init()
        //self.loadRechability()
    }
    
    let reachability = try! Reachability()

    func loadRechability(){
        reachability.whenReachable = { reachability in
               if reachability.connection == .wifi {
                   print("Reachable via WiFi")
                self.networkStatus = .connectedViaWifi
               } else {
                   print("Reachable via Cellular")
                self.networkStatus = .connectedViaCellular
            }
            if let handler = self.didReceiveNotification{
                handler(self.networkStatus)
            }
           }
           reachability.whenUnreachable = { _ in
               print("Not reachable")
            self.networkStatus = .disconnected
            if let handler = self.didReceiveNotification{
                handler(self.networkStatus)
            }
        }

           do {
               try reachability.startNotifier()
           } catch {
               print("Unable to start notifier")
           }
    }
    
}
