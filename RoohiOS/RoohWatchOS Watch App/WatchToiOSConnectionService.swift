//
//  WatchToiOSConnectionService.swift
//  RoohWatchOS Watch App
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation
import WatchConnectivity

final class WatchConnectionService: NSObject {

    static let shared = WatchConnectionService()
    private let session: WCSession
    var delegate: WatchConnectionServiceDelegate?

    var validSession: WCSession? {
#if os(iOS)
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            return session
        }
#elseif os(watchOS)
        return session
#endif
        return nil
    }
    
    private var validReachableSession: WCSession? {
        if let session = validSession , session.isReachable {
            return session
        }
        return nil
    }
    
//    private override init() {
//        self.session = WCSession.default
//        super.init()
//    #if !os(watchOS) /// Apple watch всегда поддерживают сеанс. iOS будут поддерживать сеанс только при наличии пары Apple watch
//        guard WCSession.isSupported() else {
//          return
//        }
//    #endif
//        session?.delegate = self
//        session?.activate()
//      }
    
    override init() {
            self.session = .default
            super .init()
            self.session.delegate = self
            self.session.activate()
//            self.startHandelChanges()
        }
    
    func sendMessageData(data: Data, replyHandler: ((Data) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        validReachableSession?.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    }
}

extension WatchConnectionService: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("session activation failed with error: \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print("Received message data: \(messageData)")
        delegate?.watchConnectionService(self, didReceiveMessageData: messageData)
    }
    
}

protocol WatchConnectionServiceDelegate {
    func watchConnectionService(_ service: WatchConnectionService, didReceiveMessageData messageData: Data)
}
