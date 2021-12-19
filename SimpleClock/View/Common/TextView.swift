//
//  TextView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/16.
//

import SwiftUI

struct TextView: View {
    @Binding var isShowing: Bool
    @Binding var text: String
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            VStack {   
                HStack {
                    Spacer()
                    IconButton(nameOn: "multiply", action: {
                        isShowing.toggle()
                    })
                    .padding()
                }
                
                ScrollView {
                    Text(text)
                        .foregroundColor(.text)
                        .font(.body)
                        .padding(30)
                    Spacer()
                        .frame(height: 50)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(isShowing: Binding.constant(true), text: Binding.constant(""))
    }
}
