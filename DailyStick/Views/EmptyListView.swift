//
//  EmptyListView.swift
//  DailyStick
//
//  Created by Joseph William DeWeese on 9/6/22.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        
        ZStack{
            VStack{
                
                Image("frog")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
              //      .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
