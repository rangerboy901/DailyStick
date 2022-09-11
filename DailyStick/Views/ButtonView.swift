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
                .fill(Color(.black))
                .frame(width: 72, height: 72, alignment: .center)
            Circle()
                .fill(Color("grey"))
                .frame(width: 68, height: 68, alignment: .center)
            Circle()
                .fill(Color("blue"))
                .frame(width: 48, height: 48, alignment: .center)
            
            Button(action: {
                isPresented=true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("white"))
                    .frame(width: 28, height: 28, alignment: .center)
            } //: BUTTON
            
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
                        })
                    
                }
                
                
            }
        }
    }
    
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
