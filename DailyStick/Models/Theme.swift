//
//  Theme.swift
//  DailyStick
//
//  Created by Joseph William DeWeese on 9/5/22.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    
    case indigo
    case lavender
    case magenta
    case navy
    case VolunteerOrange
    case oxblood
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case  .lavender, .VolunteerOrange, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
