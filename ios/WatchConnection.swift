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
class WatchConnection: RCTEventEmitter, WCSessionDelegate {

    enum Events: String, CaseIterable {
        case watchConnectionDidChange
    }

    private var session: WCSession?

    override static func requiresMainQueueSetup() -> Bool {
        false
    }

    override func supportedEvents() -> [String]! {
        Events.allCases.map(\.rawValue)
    }

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
        sendEvent(withName: Events.watchConnectionDidChange.rawValue, body: message)
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
    #endif

}
