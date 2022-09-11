//
//  History.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI
import RealmSwift



struct HistoryView: View {
    
    let history: History
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Exercises")
                    .font(.headline)
                Text(history.exerciseString)
            }
        }
        .navigationTitle(Text(history.date ?? Date(), style: .date))
        .padding()
    }
}

extension History {
    var exerciseString: String {
        ListFormatter.localizedString(byJoining: exercises)
    }
}

