//
//  WorkoutHistory.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import Foundation
import RealmSwift

class History: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var date: Date?
    @Persisted var exerciseList = List<String>()
    
    var exercises: [String] { Array(exerciseList) }

    convenience init(date: Date = Date(), exercises: [String]) {
        self.init()
        self.date = date
        exerciseList.append(objectsIn: exercises)
        
    }
}
