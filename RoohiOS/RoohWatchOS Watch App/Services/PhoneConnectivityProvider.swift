//
//  PhoneConnectivityProvider.swift
//  RoohWatchOS Watch App
//
//  Created by Cezar_ on 12.02.24.
//

import Foundation
import WatchConnectivity
import OSLog

final class PhoneConnectivityProvider: NSObject, WCSessionDelegate {
    private let session: WCSession
    private let logger = Logger()
    
    var onDataReceived: ((ProfileModel) -> Void)?

    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
    }
    
    func connect() {
        guard WCSession.isSupported() else {
            logger.debug("watch session is not supported")
            return
        }
        logger.debug("activating watch session")
        session.activate()
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        logger.debug("did finish activating session %lu (error: %s)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        logger.debug("\(message)")
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        do {
            let decoder = JSONDecoder()
            let receivedProfileModel = try decoder.decode(ProfileModel.self, from: messageData)
            onDataReceived?(receivedProfileModel)
        } catch {
            logger.debug("Failed to decode message data: \(error)")
        }
    }
}
