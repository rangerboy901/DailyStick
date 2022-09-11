//
//  DailyStickApp.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI

@main
struct DailyStickApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                WorkoutsList()
            }
        }
    }
}
