//
//  Ultralight.swift
//  Ultralight
//
//  Created by Ricardo DOS SANTOS on 07/01/2026.
//

import SwiftUI
import AMAShareUltralight
import mdi_mob_sdk_doc_model_ios

@main
struct UltralightApp: App {
    @State private var committedPassengers: [Passenger] = []
    var body: some Scene {
        WindowGroup {
            HomeView(committedPassengers: $committedPassengers)
        }
    }
}

struct HomeView: View {
    @Binding var committedPassengers: [Passenger]
    var body: some View {
        TabView {
            UltralightView(passengers: committedPassengers)
                .tabItem {
                    Label("Ultralight", systemImage: "star.fill")
                }
            PassengersView(committedPassengers: $committedPassengers)
                .tabItem {
                    Label("Passengers", systemImage: "person.fill")
                }
        }
    }
}
