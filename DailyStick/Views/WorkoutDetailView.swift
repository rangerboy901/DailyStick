//
//  WorkoutDetailView.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI
import RealmSwift

struct WorkoutDetailView: View {
    @ObservedRealmObject var workout: DailyWorkout
    //JWD:  PROPERTIES
    @State private var isPresented: Bool = false
    //JWD:  PROPERTIES
    @State private var data = DailyWorkout.Data()
    
    
    
    
    //JWD:  WORKOUT TYPES
    let types = ["HIIT", "Cardio", "Strength", "Power"]
    
    func colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Strength":
            return .orange
        case "Cardio":
            return .pink
        case "Power":
            return .green
        default:
            return .gray
            
        }
    }
    
    var body: some View {
        
        VStack (alignment:.leading){
            List {
                
                    Section(header: Text("Select to begin workout")){
                        NavigationLink(
                            destination:  TimerView()
                        ){
                            Label("Begin Workout", systemImage: "timer")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 3.0)
                        )}
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Section(header: Text("Workout Name:")) {
                            Text(workout.title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(1)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(self.colorize(type: workout.type ))
                                .accessibilityLabel("\(workout.title)Workout Name")
                            Divider()
                        }
                        
                        Section(header: Text("Workout Objective📝")) {
                            Text(workout.objective)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(1)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(self.colorize(type: workout.type ))
                                .accessibilityLabel("\(workout.objective)Workout Description")
                            Divider()
                        }
                        Section(header: Text("Workout Type:")) {
                            Text(workout.type)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(1)
                                .background(Color(UIColor.tertiarySystemFill))
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(self.colorize(type: workout.type ))
                                .accessibilityLabel("\(workout.type) Workout type")
                                .accessibilityElement(children: .ignore)
                            Divider()
                        }//: #endOf Section
                        Section(header: Text("Exercises")) {
                            ForEach(workout.exercises, id: \.self) {
                                exercise in
                                Label(exercise, systemImage: "target")
                                    .accessibilityLabel(Text("target"))
                                    .accessibilityValue(Text(exercise))
                            }
                            .foregroundColor(self.colorize(type: workout.type ))
                            .padding(1)
                            Divider()
                        }
                        Section(header: Text("History")) {
                            if workout.history.isEmpty {
                                Label("No completed workouts yet", systemImage: "calendar.badge.exclamationmark")
                                    .foregroundColor(self.colorize(type: workout.type ))
                            }
                            
                            ForEach(workout.history) { history in
                                NavigationLink(destination:
                                                HistoryView(history: history)) {
                                    HStack{
                                        Image(systemName: "calendar")
                                            .foregroundColor(self.colorize(type: workout.type ))
                                        if let date = history.date {
                                            Text(date, style: .date)
                                        }else {
                                            Text("Date is missing.")
                                        }
                                    }
                                    
                                }
                                
                            }//#endOfHistory
                            
                        }//#endOfSection
                    }
                    
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarItems(trailing: Button("Edit") {
                        HapticManager.notification(type: .success)
                        
                        isPresented = true
                        data = workout.data
                    })
                   
                    .fullScreenCover(isPresented: $isPresented) {
                        NavigationView {
                            WorkoutEditView(workoutData: $data, workout: workout)
                                
                                .navigationBarItems(leading: Button("Cancel") {
                                    HapticManager.notification(type: .success)
                                    
                                    isPresented = false
                                }, trailing: Button("Save") {
                                    HapticManager.notification(type: .success)
                                    isPresented = false
                                    do {
                                        try Realm().write() {
                                            guard let thawedWorkout =
                                                    workout.thaw() else {
                                                print("Unable to thaw workout")
                                                return
                                            }
                                            thawedWorkout.update(from: data)
                                        }
                                    }catch {
                                        print("Failed to save workout: \(error.localizedDescription)")
                                    }
                                })
                        }
                    }
                }
            

            }
        }
    }

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(workout: DailyWorkout.data[0])
        }
    }
}

    
