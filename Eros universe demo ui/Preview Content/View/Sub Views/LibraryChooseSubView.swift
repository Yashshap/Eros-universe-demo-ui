//
//  LibraryChooseSubView.swift
//  Eros universe demo ui
//
//  Created by Apple on 13/06/25.
//

import SwiftUI


struct LibraryChooseSubView: View {
    var body: some View {
        ZStack {
            Color(red: 39/255, green: 38/255, blue: 54/255)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Choose from library")
                    .foregroundStyle(Color.white)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(100))], spacing: 15) {
                        ForEach(0..<10) { index in
                            let imageName = "anime\(index+1)"
                            
                            ZStack {
                                            if let uiImage = UIImage(named: imageName) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } else {
                                                // Placeholder if image is not available
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.gray.opacity(0.3))
                                                    Image(systemName: "photo")
                                                        .font(.system(size: 30))
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(10)
                        }
                    }
                }
                .frame(height: 100)
            }
            .padding(.horizontal) // Only one horizontal padding applied here
        }
        .frame(width: 377, height: 170)

        .cornerRadius(7)
//        .padding(.horizontal) // Outer margin from screen edges
    }
}


#Preview {
    LibraryChooseSubView()
}
