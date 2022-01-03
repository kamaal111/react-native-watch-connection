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
    private var lastMessage: CFAbsoluteTime = 0

    private let watchConnectionErrorKey = "watch_connection_error"

    override static func requiresMainQueueSetup() -> Bool {
        false
    }

    override func supportedEvents() -> [String]! {
        Events.allCases.map(\.rawValue)
    }

    @objc
    public func activate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            self.session = session
        }
    }

    @objc
    public func sendMessage(_ message: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        guard let session = self.session else {
            reject(watchConnectionErrorKey, "Watch connection is not activated", nil)
            return
        }

        if lastMessage + 0.5 > CFAbsoluteTimeGetCurrent() {
            reject(watchConnectionErrorKey, "Too many messages sent too quickly", nil)
            return
        }

        guard session.isReachable else {
            reject(watchConnectionErrorKey, "Watch is not reachable", nil)
            return
        }

        session.sendMessage(message, replyHandler: nil)
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
