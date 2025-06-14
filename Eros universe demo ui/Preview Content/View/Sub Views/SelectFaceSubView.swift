//
//  SelectFaceForSwapView.swift
//  Eros universe demo ui
//
//  Created by Apple on 13/06/25.
//
import SwiftUI
import PhotosUI

struct SelectFaceSubView: View {
    
    @Binding var sourceImage: UIImage?
    @Binding var targetImage: UIImage?
    @Binding var swappedImage: UIImage? // optional
    
    
    @State private var sourcePickerItem: PhotosPickerItem?
    @State private var targetPickerItem: PhotosPickerItem?
  
    
    
    var body: some View {
        
        VStack {
            // 5:7 Aspect Ratio Example – 300x214 (Height < Width)
            let containerWidth: CGFloat = 350
            let containerHeight: CGFloat = containerWidth * 5 / 7
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("Source Image")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundStyle(Color.white)
                    // this is the image place holder for target image
                    VStack(alignment: .leading) {
                                Text("Source Image")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundStyle(Color.white)

                                PhotosPicker(selection: $sourcePickerItem, matching: .images, photoLibrary: .shared()) {
                                    if let image = targetImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(5/7, contentMode: .fit)
                                            .frame(width: 120, height: 168)
                                            .cornerRadius(8)
                                    } else {
                                        Image("targetPlaceholder") // <- your asset image name
                                            .resizable()
                                            .aspectRatio(5/7, contentMode: .fit)
                                            .frame(width: 120, height: 168)
                                            .cornerRadius(8)
                                    }
                                }
                                .onChange(of: sourcePickerItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                                           let image = UIImage(data: data) {
                                            targetImage = image
                                        }
                                    }
                                }
                            }                }
                
                
                VStack(alignment: .center) {
//                    Text("Add your Face to Swap")
//                        .font(.custom("Poppins-Regular", size: 14))
//                        .foregroundStyle(Color.white)
                    VStack(alignment: .center) {
                        if let swappedImage = swappedImage {
                            // ✅ Show "Swapped Image" and rectangular preview
                            Text("Swapped Image")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(Color.white)
                            
                            Image(uiImage: swappedImage)
                                .resizable()
                                .aspectRatio(5/7, contentMode: .fit)
                                .frame(width: 120, height: 168)
                                .cornerRadius(8)
                        } else {
                            // 🔄 Show original layout: title + face placeholders
                            Text("Add your Face to Swap")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(Color.white)
                            
                            VStack(spacing: 8) {
                                
                                PhotosPicker(selection: $targetPickerItem, matching: .images, photoLibrary: .shared()) {
                                           if let sourceFace = sourceImage {
                                               Image(uiImage: sourceFace)
                                                   .resizable()
                                                   .aspectRatio(contentMode: .fill)
                                                   .frame(width: 65, height: 65)
                                                   .clipShape(Circle())
                                           } else {
                                               Circle()
                                                   .fill(Color.gray.opacity(0.3))
                                                   .frame(width: 65, height: 65)
                                                   .overlay(
                                                       Image(systemName: "photo")
                                                           .font(.system(size: 24))
                                                           .foregroundColor(.gray)
                                                   )
                                           }
                                       }
                                       .onChange(of: targetPickerItem) { newItem in
                                           Task {
                                               if let data = try? await newItem?.loadTransferable(type: Data.self),
                                                  let image = UIImage(data: data) {
                                                   sourceImage = image
                                               }
                                           }
                                       }
                            }
                        }
                    }
                    
                }
                                
            }
            .frame(width: containerWidth, height: containerHeight)
            .padding()
            .background(Color(red: 39/255, green: 38/255, blue: 54/255))
            .cornerRadius(7)
            .padding(.horizontal)
            
        }
        
    }
}
    
//#Preview {
//    StatefulPreviewWrapper(
//        UIImage(named: "anime1"),
//        UIImage(named: "anime2"),
//        UIImage(named: "swapped")
//    ) { sourceImage, targetImage, swappedImage in
//        SelectFaceSubView(
//            sourceImage: sourceImage,
//            targetImage: targetImage,
//            swappedImage: swappedImage
//        )
//    }
//}
//
//    
//
//struct StatefulPreviewWrapper<A, B, C, Content: View>: View {
//    @State var a: A
//    @State var b: B
//    @State var c: C
//    var content: (Binding<A>, Binding<B>, Binding<C>) -> Content
//    
//    init(_ a: A, _ b: B, _ c: C, content: @escaping (Binding<A>, Binding<B>, Binding<C>) -> Content) {
//        _a = State(initialValue: a)
//        _b = State(initialValue: b)
//        _c = State(initialValue: c)
//        self.content = content
//    }
//    
//    var body: some View {
//        content($a, $b, $c)
//    }
//}
