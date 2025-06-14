//
//  CustomNavbar.swift
//  Eros universe demo ui
//
//  Created by Apple on 13/06/25.
//

// CustomNavBar.swift
import SwiftUI

struct CustomNavBar: View {
    let title: String
    let showBackButton: Bool
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                }
                .padding(.leading)
            } else {
                Spacer().frame(width: 44) // Keeps the title centered
            }

            Spacer()
            
            Text(title)
                .font(.custom("Poppins-Bold", size: 20))
                .foregroundColor(.white)

            Spacer()

            Spacer().frame(width: 44) // Matches left padding
        }
        .frame(height: 50)
        .background(Color.black)
    }
}

#Preview {
    CustomNavBar(title: "name", showBackButton: true )
}
