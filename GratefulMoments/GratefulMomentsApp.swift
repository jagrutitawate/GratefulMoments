//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Jagruti Parab on 10/11/26.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {

    let dataContainer = DataContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
