//
//  WorkoutEditView.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI
import RealmSwift

struct WorkoutEditView: View {
    //JWD:  PROPERTIES
    @Binding var workoutData: DailyWorkout.Data
    @State private var newExercise = ""
    @ObservedRealmObject var workout: DailyWorkout
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
                
                Section(header: Text("Workout Details")) {
                    
                    TextField("Enter workout name...", text: $workoutData.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workoutData.type ), lineWidth: 3.0))
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(self.colorize(type: workoutData.type ))
                    Section("Workout Objective📝") {
                      TextEditor(text: $workoutData.objective)
                            .frame(width: 350, height: 125, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(self.colorize(type: workoutData.type ))
                        .accessibilityLabel("\(workoutData.objective)Workout Description")
                    
                    Text("Workout Type:")
                    Picker("Workout Type:", selection: $workoutData.type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workoutData.type ), lineWidth: 3.0))
                    
                    Section(header: Text("Exercises")) {
                        ForEach(workoutData.exercises, id: \.self) { exercise in
                            Text(exercise)
                        }
                        .onDelete { indices in
                            workoutData.exercises.remove(atOffsets: indices)
                        }
                        HStack {
                            TextField("Enter new exercise...", text: $newExercise)
                            Button(action: {
                                HapticManager.notification(type: .success)
                                withAnimation {
                                    workoutData.exercises.append(newExercise)
                                    newExercise = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .accessibilityLabel(Text("Add exercise"))
                            }
                            .disabled(newExercise.isEmpty)
                            .foregroundColor(self.colorize(type: workout.type))
                        }
                         
                    }//: #endOf Section
                
                }//: #endOf List
                .listStyle(InsetGroupedListStyle())
                
            }
        }
        
    }
}
                                    
                                
                            
//                                        .navigationTitle("Workout Details")
//                                        .navigationBarTitleDisplayMode(.inline)
//                                        .navigationBarItems(trailing: Button("Edit") {
//                                            isPresented = true
//                                             data = workout.data
//                                        })
//                                        .navigationTitle(workoutData.title)
//                                        .fullScreenCover(isPresented: $isPresented) {
//                                            NavigationView {
//                                                WorkoutEditView()
//                                                    .navigationTitle(workoutData.title)
//                                                    .navigationBarItems(leading: Button("Cancel") {
//                                                        isPresented = false
//
//                                                    })
                                    
//: #endOf Section
                       
