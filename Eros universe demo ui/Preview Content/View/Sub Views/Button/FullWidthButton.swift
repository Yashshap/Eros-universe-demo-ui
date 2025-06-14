//
//  PrimaryButton.swift
//  Eros universe demo ui
//
//  Created by Apple on 13/06/25.
//

import SwiftUI

struct FullWidthButton: View {
    var title: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    FullWidthButton(title: "Swap Face Now >")
}
