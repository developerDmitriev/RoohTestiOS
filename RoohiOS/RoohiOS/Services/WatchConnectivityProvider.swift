//
//  WatchConnectivityProvider.swift
//  RoohiOS
//
//  Created by Cezar_ on 12.02.24.
//

import Foundation
import WatchConnectivity
import OSLog

final class WatchConnectivityProvider: NSObject, WCSessionDelegate {
    private let session: WCSession
    let logger = Logger()
    var onDataReceived: ((CreateProfileModel) -> Void)?
    
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
        logger.debug("did finish activating session (\(String(describing: error))")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        logger.debug("session became inactive")
    }
         
    func sessionDidDeactivate(_ session: WCSession) {
        logger.debug( "session deactivated")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        logger.debug("did receive message: \([WatchCommunication.requestKey])")
            guard let contentString = message[WatchCommunication.requestKey] as? String , let content = WatchCommunication.Content(rawValue: contentString) else {
                replyHandler([:])
                return
            }
            switch content {
            case .profileModel:
                    let converted = CreateProfileModel(age: 123, height: 666, weight: 777)
                    let response = [WatchCommunication.responseKey: converted]
                    replyHandler(response)
            }
        }
    
    func sendMessage() {
        if session.isReachable {
            let message = ["Message":"Hello"]
            session.sendMessage(message, replyHandler: nil)
        }
    }
    
    func sendMessageData(with data: Data, errorHandler: (Error) -> Void) {
        if session.isReachable {
            session.sendMessageData(data, replyHandler: nil)
        } else {
            let error = Errors.sessionIsntReachable
            logger.debug("session isn't reachable")
            errorHandler(error)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        do {
            let decoder = JSONDecoder()
            let receivedProfileModel = try decoder.decode(CreateProfileModel.self, from: messageData)
            onDataReceived?(receivedProfileModel)
        } catch {
            logger.debug("Failed to decode message data: \(error)")
        }
    }

}

struct WatchCommunication {
    static let requestKey = "request"
    static let responseKey = "response"
     
    enum Content: String {
        case profileModel
    }
}
