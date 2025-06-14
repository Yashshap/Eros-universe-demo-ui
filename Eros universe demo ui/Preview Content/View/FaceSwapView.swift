//
//  erosUniveres.swift
//  Eros universe demo ui
//
//  Created by Apple on 13/06/25.
//

import SwiftUI

struct FaceSwapView: View {
    @State  var sourceImage: UIImage?
    @State  var targetImage: UIImage?
    @State  var swappedImage: UIImage?

    
    var body: some View {
        
        
           
            VStack(alignment: .center, spacing: 20) {
                CustomNavBar(
                    title: "EROS UNIVERSE",
                    showBackButton: true
                    
                )
                // Title
                Text("Eros now photos and videos face swap ai")
                    
                    .font(.custom("Poppins-Regular", size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                
                // Segmented Control
                SegmentedControllView()
                LibraryChooseSubView()
                SelectFaceSubView(sourceImage: $sourceImage,targetImage: $targetImage,swappedImage: $swappedImage)
                Spacer()

                FullWidthButton(title: "Swap Face Now >"){
                    guard let src = sourceImage, let tgt = targetImage else { return }
                       performFaceSwap(sourceImage: src, targetImage: tgt) { result in
                           self.swappedImage = result
                       }
                }
                .frame(height: 16)
               Text("4 Creations left")
                    .font(.system(size: 13)) 
                    .foregroundStyle(Color.white)
                    
                
               
            }
            .background(Color.black.opacity(0.9))
        }
    }


#Preview {
   FaceSwapView()
}




struct SegmentedControllView: View {
    @State private var selectedOption: Int = 0
    let options = ["Photo Face Swap", "Multiple Face Swap", "Video Face Swap"]
    var body: some View {
        ZStack() {
            // Background track
            
            
            GeometryReader { geometry in
                let totalPadding: CGFloat = 40 // 15 leading + 15 trailing
                let buttonWidth = (geometry.size.width - totalPadding) / CGFloat(options.count)
                let verticalOffset: CGFloat = (35 - 30) / 2 // Center 30-height slider inside 35-height background
                
                
                
                
                // Background track
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(Color.gray.opacity(0.2)))
                    .frame(height: 35)
                    .padding(.horizontal, 15)
                
                // Sliding indicator
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.teal)
                    .frame(width: buttonWidth, height: 30)
                    .offset(x: 18 + buttonWidth * CGFloat(selectedOption), y: verticalOffset )
                    .animation(.easeInOut(duration: 0.3), value: selectedOption)
                
                // Buttons
                HStack(spacing: 3) {
                    ForEach(options.indices, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedOption = index
                            }
                        }) {
                            Text(options[index])
                                .font(.custom("Poppins-Regular", size: 13))
                                .foregroundColor(.white)
                                .frame(width: buttonWidth, height: 35)
                        }
                    }
                }
                .padding(.horizontal,15)
            }
            .frame(height: 50)
        }
    }
}
