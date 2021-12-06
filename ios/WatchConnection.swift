//
//  WatchConnection.swift
//  WatchConnection
//
//  Created by Kamaal M Farah on 06/12/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import WatchConnectivity

@objc(WatchConnection)
class WatchConnection: NSObject, WCSessionDelegate {

//    @objc(multiply:withB:withResolver:withRejecter:)
//    func multiply(a: Float, b: Float, resolve: RCTPromiseResolveBlock,reject: RCTPromiseRejectBlock) -> Void {
//        resolve(a*b)
//    }
    private var session: WCSession?

    @objc
    func activate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            self.session = session
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
    #endif

}
