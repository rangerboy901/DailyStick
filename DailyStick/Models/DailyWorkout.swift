//
//  DailyWorkout.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import RealmSwift
import SwiftUI
import Foundation


///JWD:   Specific data types in Realm must be initialized with a value. Will initialize with an empty string.
class DailyWorkout: Object, ObjectKeyIdentifiable {
   
    @Persisted var title = ""
    @Persisted var objective = ""
    @Persisted var type = ""
    @Persisted var exerciseList = RealmSwift.List<String>()
    @Persisted var colorComponents: Components?
    @Persisted var historyList = RealmSwift.List<History>()
    
    
    
    var color: Color { Color(colorComponents ?? Components()) }
    var exercises: [String] { Array(exerciseList) }
    var history: [History] { Array(historyList) }
    static let shared = DailyWorkout()
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    
    var workouts: String = ""
    convenience init(title: String,objective: String,type: String, exercises: [String], color: Color, history: [History] = []) {
        self.init()
        self.title = title
        self.objective = objective
        self.type = type
        exerciseList.append(objectsIn: exercises)
        self.colorComponents = color.components
        for entry in history {
            self.historyList.insert(entry, at: 0)
        }
    }
}

extension DailyWorkout {
    static var data: [DailyWorkout] {
        [
            DailyWorkout(title: "Dakota", objective: "Complete for Time.", type: "HIIT", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], color: Color("HIIT")),
            DailyWorkout(title: "Remington", objective: "Complete for Time.", type: "Power", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], color: Color("Power")),
            DailyWorkout(title: "Montana", objective: "Complete for Time.", type: "Strength", exercises:[ "Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], color: Color("Strength")),
            DailyWorkout(title: "Cooper", objective: "Complete for Time.", type: "Cardio", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"], color: Color("Cardio")),
        ]
    }
}
extension DailyWorkout {
    struct Data {
        var title: String = ""
        var objective: String = ""
        var type: String = ""
        var exercises: [String] = []
        var color: Color = .random
    }
    var data: Data {
        return Data(title: title, objective: objective, type: type, exercises: exercises, color: color)
    }
    
    func update(from data: Data) {
        title = data.title
        objective = data.objective
        type = data.type
        for exercise in data.exercises {
            if !exercises.contains(exercise) {
                self.exerciseList.append(exercise)
            }
        }
        
        colorComponents = data.color.components
    }
}



