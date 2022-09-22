//
//  WorkoutsList.swift
//  DailyStick
//
//  Created by Joseph William DeWeese on 9/5/22.
//

import SwiftUI
import RealmSwift



struct WorkoutsList: View {
    
    
    @ObservedResults(DailyWorkout.self) var workouts
    @State private var newWorkoutData = DailyWorkout.Data()
    @State private var showingEditWorkoutView: Bool = false
    @State private var showingMenuView: Bool = false
    @State private var currentWorkout = DailyWorkout()
    @State  var isPresented = false
    let workout = DailyWorkout()
    
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottom){
                    List {
                        if let workouts = workouts {
                            ForEach(workouts) { workout in
                                NavigationLink(
                                    destination: WorkoutDetailView(workout: workout)) {
                                        WorkoutCellView(workout: workout)
                                    }
                            }//TODO   delete row
                        }
                    }///#endOfList
                ButtonView()
                }///#endOfZStack
            }///#endOfNavigation
        }
    }
struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsList()
        }
    }
}

