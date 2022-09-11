//
//  WorkoutCellView.swift
//  DailyStick
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI

struct WorkoutCellView: View {
    
    let workout: DailyWorkout
    
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
            HStack {
    
                Text(workout.title)
                    .fontWeight(.semibold)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.primary)
            }
            Text(workout.objective)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .accessibilityLabel("\(workout.objective)Workout Description")
            
            HStack{
                Spacer()
                Text("\(workout.type)")
                    .foregroundColor(Color.primary)
                    .accessibilityLabel("\(workout.type) Workout type")
                    .font(.caption2)
                    .padding(6)
                    .overlay(
                        Capsule().stroke(self.colorize(type: workout.type ), lineWidth: 4))
                        }
            .padding(.trailing, 15)
            .cornerRadius(10)
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)),Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))]), startPoint: .bottom, endPoint: .top))
        .overlay(
            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 5.0))
    }
}

struct WorkoutCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WorkoutCellView(workout: DailyWorkout(title: "Dakota", objective: "complete as Rx'd", type: "HIIT", exercises: ["push-ups"], color: .blue))
        }
    }
}
