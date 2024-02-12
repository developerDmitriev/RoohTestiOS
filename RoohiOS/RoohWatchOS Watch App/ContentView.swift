//
//  ContentView.swift
//  RoohWatchOS Watch App
//
//  Created by Cezar_ on 09.02.24.
//

import SwiftUI
struct ContentView: View {
    @State private var isModelChanged = false
    @State var profileModel = ProfileModel(age: 0, height: 0, weight: 0)
    @State var isDataSent = false
    let phoneConnectionProvider = PhoneConnectivityProvider()
    
    var body: some View {
        ScrollView {
            profileModel.avatar?.base64.base64Convert()
            VStack(spacing: 8, content: {
                Text("Name: \(profileModel.avatar?.name ?? "noname")")
                Text("Age: \(profileModel.age)")
                    .focusable(true)
                    .digitalCrownRotation($profileModel.age,
                                          from: 0,
                                          through: Constants.maxAge,
                                          by: Constants.digitalCrownRotationChangeBy,
                                          sensitivity: .high,
                                          isContinuous: Constants.isContinueDigitalCrownScrolling,
                                          isHapticFeedbackEnabled: true)
                Text("height: \(profileModel.height)")
                    .focusable(true)
                    .digitalCrownRotation($profileModel.height,
                                          from: 0,
                                          through: 1000,
                                          by: Constants.digitalCrownRotationChangeBy,
                                          sensitivity: .high,
                                          isContinuous: Constants.isContinueDigitalCrownScrolling,
                                          isHapticFeedbackEnabled: true)
                Text("weight: \(profileModel.weight)")
                    .focusable(true)
                    .digitalCrownRotation($profileModel.weight,
                                          from: 0,
                                          through: Constants.maxWeight,
                                          by: Constants.digitalCrownRotationChangeBy,
                                          sensitivity: .high,
                                          isContinuous: Constants.isContinueDigitalCrownScrolling,
                                          isHapticFeedbackEnabled: true)
            })
            Spacer()
            Button("Send to iPhone") {
                _ = sendProfileModelToPhone()
            }
            .alert(isPresented: $isDataSent, content: {
                isDataSent ? Alert(title: Text("Data sent")) : Alert(title: Text("Data haven't sent"))
            })
            .disabled(!isModelChanged)
            .onChange(of: profileModel) { _ in
                self.isModelChanged = true
            }
            .onAppear {
                phoneConnectionProvider.connect()
                phoneConnectionProvider.onDataReceived = { receivedProfileModel in
                    self.profileModel = receivedProfileModel
                }
            }
        }
    }
    
    func sendProfileModelToPhone() -> Bool {
        var isSent = false
        
        defer {
            isDataSent = isSent
        }
        
        guard let data = try? JSONEncoder().encode(profileModel) else { return isSent}
        phoneConnectionProvider.sendMessageData(with: data) { error in
            return
        }
        isSent = true
        return isSent
    }
}

extension ContentView {
    enum Constants {
        static let digitalCrownRotationChangeBy = 1.0
        static let maxAge = 200.0
        static let maxWeight = 600.0
        static let maxHeight = 700.0
        static let isContinueDigitalCrownScrolling = false
    }
}

#Preview {
    ContentView()
}
