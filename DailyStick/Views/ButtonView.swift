//
//  ButtonView.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/10/22.
//

import SwiftUI
import RealmSwift

struct ButtonView: View {
    @ObservedResults(DailyWorkout.self) var workouts
    @State private var newWorkoutData = DailyWorkout.Data()
    @State private var showingEditWorkoutView: Bool = false
    @State private var showingMenuView: Bool = false
    @State private var currentWorkout = DailyWorkout()
    @State  var isPresented = false
    let workout = DailyWorkout()
    
    
    
    var body: some View {
        
        Group {
            
            Circle()
                .fill(Color("blue"))
                .frame(width: 70, height: 70, alignment: .bottom)
            
            Button(action: {
                isPresented=true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("white"))
                    .frame(width: 28, height: 28, alignment: .center)
                    
            } //: BUTTON
            
            .padding(.bottom, 20)
            .sheet(isPresented: $isPresented) {
               
                    WorkoutEditView(workoutData: $newWorkoutData, workout: workout)
                        .navigationBarItems(leading: Button("Cancel"){
                            HapticManager.notification(type: .success)
                            isPresented = false
                            
                        },
                                            
                        trailing: Button("Save") {
                            HapticManager.notification(type: .success)
                            let newWorkout = DailyWorkout(
                                title: newWorkoutData.title,
                                objective: newWorkoutData.objective, timeGoal: Int(newWorkoutData.timeGoal),
                                type: newWorkoutData.type,
                                exercises: newWorkoutData.exercises)
                               
                            $workouts.append(newWorkout)
                            isPresented = false
                        })
                    
                    
                    
                }
            }
      
        }
    }

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
