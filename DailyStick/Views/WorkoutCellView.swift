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
                    .padding(3)
            }
            Text(workout.objective)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(self.colorize(type: workout.type ))
              
            
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
         
          
            
        }
        .padding()
    //    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .bottom, endPoint: .top))
        .overlay(
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 40)).stroke(self.colorize(type: workout.type ), lineWidth: 5.0))
        
    }
}

struct WorkoutCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WorkoutCellView(workout: DailyWorkout(title: "Dakota", objective: "complete as Rx'd", type: "HIIT", exercises: ["push-ups"], color: .blue))
        }
    }
}
