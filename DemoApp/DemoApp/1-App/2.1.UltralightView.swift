//
//  ContentView.swift
//  Ultralight
//
//  Created by Ricardo DOS SANTOS on 07/01/2026.
//

import SwiftUI
import Combine
import mdi_mob_sdk_doc_model_ios
import AMAShareUltralight

enum Event {
    case time(id: String, value: String)
    case error(message: String, sender: String)
    case debug(message: String, sender: String)
    case hubConnected
    case eventReceived(event: String, payload: String)
    case sendTypes(types: String)
}

enum Constants {
    static let apiKey1 = "DEV-dd7bfb04-2383-4540-b17d-1c0605bbb387"
    static let apiKey2 = "STG-ed7a2be6-68cd-4d5a-a9b2-a49d253c659a"
    static let boardingPass = "M1NLDDE/LISELOTTE     EXYZ123 WSISUBLH 3456 139F035A0001 100"
    static let mrz = "P<NLDLISELOTTE<<NLDDE<<<<<<<<<<<<<<<<<<<<<<<1234561390NLD9702204F3003091<<<<<<<<<<<<<<08"
}

struct UltralightView: View {
    let passengers: [Passenger]
    @StateObject var listener = UltralightListener()
    var ultralight: AMAShareUltralight.Ultralight = .init()
    @State private var events: [String] = []
    @State private var apiKey: String = Constants.apiKey2
    @State private var touchpointId: String = "795d47e0d81b486a"
    @State private var time: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                btnWithClosure(title: "Swap API") {
                    let sender = "Swap API Key"
                    if apiKey == Constants.apiKey1 {
                        apiKey = Constants.apiKey2
                    } else {
                        apiKey = Constants.apiKey1
                    }
                    handle(event: .debug(message: "Changed apiKey to: \(apiKey.prefix(10))...", sender: sender))
                }
                Text(apiKey.prefix(10))
                    .font(.footnote)
                    .padding(.vertical, -10)

                btnWithClosure(title: "initialise") {
                    let sender = "initialise"
                    ultralight.initialise(apiKey: apiKey)
                    handle(event: .debug(message: "OK", sender: sender))
                }
                btnWithClosure(title: "softStart") {
                    Task {
                        let sender = "softStart"
                        let result = await ultralight.softStart()
                        switch result {
                        case .success:
                            handle(event: .debug(message: "OK", sender: sender))
                        case .failure(let error):
                            handle(event: .error(message: "\(error)", sender: sender))
                        }
                    }
                }
                Divider()
                Group {
                    btnWithClosure(title: "startBeamsync") {
                        let sender = "startBeamsync"
                        let startBeamsyncResult = ultralight.startBeamsync()
                        if startBeamsyncResult == "ALL_GRANTED" {
                            handle(event: .debug(message: startBeamsyncResult, sender: sender))
                        } else {
                            handle(event: .error(message: startBeamsyncResult, sender: sender))
                        }
                    }
                    btnWithClosure(title: "setPassengers: \(passengers.count)") {
                        let sender = "setPassengers"
                        do {
                            try ultralight.setPassengers(passengers: passengers)
                            handle(event: .debug(message: "Done", sender: sender))
                        } catch {
                            handle(event: .error(message: error.localizedDescription, sender: sender))
                        }
                    }
                    btnWithClosure(title: "getPassengers") {
                        let sender = "getPassengers"
                        do {
                            let result = ultralight.getPassengers()
                            handle(event: .debug(message: "\(result.map({ $0.mrz }))", sender: sender))
                        } catch {
                            handle(event: .error(message: error.localizedDescription, sender: sender))
                        }
                    }
                    btnWithClosure(title: "stopBeamsync") {
                        let sender = "stopBeamsync"
                        ultralight.stopBeamsync()
                        handle(event: .debug(message: "", sender: sender))
                    }

                }
                Divider()
                Group {
                    HStack {
                        Spacer()
                        TextField("touchpointId", text: $touchpointId)
                        Spacer()
                    }
                    btnWithClosure(title: "sendMessage to [\(touchpointId)]") {
                        let sender = "sendMessage"
                        ultralight.sendMessage(touchpointId: touchpointId, message: "Hi \(Date())")
                        handle(event: .debug(message: "", sender: sender))
                    }
                    btnWithClosure(title: "setDeviceId") {
                        let sender = "setDeviceId"
                        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
                        ultralight.setDeviceId(deviceId: deviceId)
                        handle(event: .debug(message: "", sender: sender))
                    }
                    btnWithClosure(title: "isBeamsyncActive?") {
                        let sender = "isBeamsyncActive"
                        let result = ultralight.isBeamsyncActive()
                        handle(event: .debug(message: "\(String(describing: result.description))", sender: sender))
                    }
                    btnWithClosure(title: "getProviderVersion") {
                        let sender = "getProviderVersion"
                        let version = ultralight.getProviderVersion()
                        handle(event: .debug(message: "\(String(describing: version.version))", sender: sender))
                    }
                }
                Divider()
                debugView
                btnWithClosure(title: "Clear logs") {
                    events = []
                }
            }.onReceive(listener.passthrough) { event in
                handle(event: event)
            }
            .padding()
        }
    }
}

extension UltralightView {
    var passagenger: some View {
        List(passengers.indices, id: \.self) { index in
            VStack(alignment: .leading) {
                Text("Passenger \(index + 1)")
                    .font(.headline)
                Text(passengers[index].mrz ?? "")
                    .font(.footnote)
            }
        }
    }

    var debugView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(events.indices, id: \.self) { index in
                        Text(events[index])
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(.green)
                            .id(index)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 200)
            .background(Color.black.opacity(0.1))
            .cornerRadius(8)
            .onChange(of: events.count) { _ in
                withAnimation {
                    proxy.scrollTo(events.indices.last, anchor: .bottom)
                }
            }
        }.padding(.horizontal)
    }

    func btnWithClosure(title: String, block: @escaping () -> Void) -> some View {
        Button(action: {
            OperationTimer.shared.start(id: title)
            block()
            if let time = OperationTimer.shared.end(id: title) {
                handle(event: .time(id: title, value: "\(time)"))
            }
        }) {
            Text(title)
        }
    }
}

extension UltralightView {
    private func handle(event: Event) {
        let timestamp = Date().formatted(date: .omitted, time: .standard)
        let message: String = switch event {
        case .hubConnected: "🟢 Connected"
        case .sendTypes(let types): "📦 Types: \(types)"
        case .eventReceived(event: let event, payload: let payload): "📩 reveived event: \(event) w/payload: \(payload)"
        case .debug(message: let message): "📋 Debug: \(message)"
        case .error(message: let message): "🟥 Error: \(message)"
        case .time(id: let id, value: let value): "⏰ : \(id) - \(value)s"
        }
        events.append("[\(timestamp)] \(message)")
    }
}

class UltralightListener: ObservableObject, UltralightListenerProtocol {
    let passthrough = PassthroughSubject<Event, Never>()
    func eventReceived(event: String, payload: String) {
        passthrough.send(.eventReceived(event: event, payload: payload))
    }

    func sendTypes(types: String) {
        passthrough.send(.sendTypes(types: types))
    }
}

#Preview {
    UltralightView(passengers: [])
}
