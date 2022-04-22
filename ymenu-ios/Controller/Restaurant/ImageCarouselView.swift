//
//  ImageCarouselView.swift
//  ymenu-ios
//
//  Created by Mattéo Dinville on 09/03/2022.
//

import SwiftUI
import Combine

struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }
    var body: some View {
        GeometryReader { geometry in
            // 1
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                .mask(
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .center, endPoint: .bottom)
                )
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .gesture(DragGesture().onChanged{ value in
                    self.slideGesture = value.translation
                }
                    .onEnded{ value in
                        if self.slideGesture.width < -50 {
                            if self.currentIndex < self.numberOfImages - 1 {
                                withAnimation {
                                    self.currentIndex += 1
                                }
                            }
                        }
                        if self.slideGesture.width > 50 {
                            if self.currentIndex > 0 {
                                withAnimation {
                                    self.currentIndex -= 1
                                }
                            }
                        }
                        self.slideGesture = .zero
                    })
                // 2
                HStack(spacing: 6) {
                    // 3
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        // 4
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.themeTextField : .white)
                            .padding(.bottom, 20)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}   
struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ImageCarouselView(numberOfImages: 3) {
                Image("1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
        }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    }
}

