//
//  WorkoutHistory.swift
//  DailyStick
//
//  Created by Joseph William DeWeese on 9/5/22.
//

import Foundation
import RealmSwift

class History: EmbeddedObject, ObjectKeyIdentifiable {
   @Persisted var date: Date?
   @Persisted var exerciseList = List<String>()
   @Persisted var timeGoal: Int = 0
   
   var exercises: [String] { Array(exerciseList) }

   convenience init(date: Date = Date(), exercises: [String], timeGoal: Int) {
      self.init()
      self.date = date
      exerciseList.append(objectsIn: exercises)
      self.timeGoal = timeGoal

   }
}
