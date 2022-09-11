//
//  WorkoutsList.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
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
            ZStack {
                List {
                    if let workouts = workouts {
                        ForEach(workouts) { workout in
                            NavigationLink(
                                destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutCellView(workout: workout)
                                }
                        }//TODO   delete row
                        
                    }
                    
                }
                
                //JWD:  IF NO WORKOUTS IN LIST
                if workouts.count == 0 {
                    EmptyListView()
                }
            } ///  #endOf ZStack
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    WorkoutEditView(workoutData: $newWorkoutData, workout: workout)
                        .navigationBarItems(leading: Button("Cancel"){
                            HapticManager.notification(type: .success)
                            isPresented = false
                            
                        }, trailing: Button("Save") {
                            HapticManager.notification(type: .success)
                            let newWorkout = DailyWorkout(
                                title: newWorkoutData.title,
                                objective: newWorkoutData.objective,
                                type: newWorkoutData.type,
                                exercises: newWorkoutData.exercises,
                                color: newWorkoutData.color)
                            $workouts.append(newWorkout)
                            isPresented = false
                        }
                            .foregroundColor(.green)
                        )
                }
            }
            .overlay(
                ZStack{
                    ButtonView()
                        .padding(.bottom, 15)
                    
                    
                }///#endOf ZStack
            )///#endOf Overlay
        }///#endOf Navigation
        .navigationBarTitle("Daily Workouts")
        .navigationBarItems(
            leading:
                Button(action: {
                    self.showingMenuView.toggle()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .imageScale(.large)
                } //: SETTINGS BUTTON
                .accentColor(.blue)
                .sheet(isPresented: $showingMenuView) {
                    MenuView()
                }
        )
    }
    
}



struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsList()
        }
    }
}

