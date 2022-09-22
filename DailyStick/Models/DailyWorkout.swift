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
    @Persisted var timeGoal = 47
    @Persisted var type = ""
    @Persisted var exerciseList = RealmSwift.List<String>()
    @Persisted var historyList = RealmSwift.List<History>()
    
    
    
    var exercises: [String] { Array(exerciseList) }
    var history: [History] { Array(historyList) }
    static let shared = DailyWorkout()
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    
    var workouts: String = ""
    convenience init(title: String,objective: String, timeGoal: Int, type: String, exercises: [String], history: [History] = []) {
        self.init()
        self.title = title
        self.objective = objective
        self.timeGoal = timeGoal
        self.type = type
        exerciseList.append(objectsIn: exercises)
       
        for entry in history {
            self.historyList.insert(entry, at: 0)
        }
    }
}

extension DailyWorkout {
    static var data: [DailyWorkout] {
        [
            DailyWorkout(title: "Dakota", objective: "Complete for Time.", timeGoal: 58, type: "HIIT", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"]),
            DailyWorkout(title: "Remington", objective: "Complete for Time.", timeGoal: 56, type: "Power", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"]),
            DailyWorkout(title: "Montana", objective: "Complete for Time.", timeGoal: 57, type: "Strength", exercises:[ "Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"]),
            DailyWorkout(title: "Cooper", objective: "Complete for Time.", timeGoal: 43, type: "Cardio", exercises: ["Run 1 Mile","100 Push-Ups", "100 Pull-ups", "100 Sit-ups"]),
        ]
    }
}
extension DailyWorkout {
    struct Data {
        var title: String = ""
        var objective: String = ""
        var type: String = ""
        var timeGoal: Double = 47.0
        var exercises: [String] = []
       
    }
    var data: Data {
        return Data(title: title, objective: objective, type: type, timeGoal: Double(timeGoal), exercises: exercises)
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
        timeGoal = Int(data.timeGoal)
      
    }
}



