//
//  ARView.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 29/01/2021.
//

import SwiftUI

struct ARView: View {
    @State private var isPresented = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isPresented = true
                }) {
                HStack {
                    Image(systemName: "arkit")
                    Text("Voir en RA")
                        .bold()
                }}
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(.greatestFiniteMagnitude)
                .sheet(isPresented: $isPresented) {
                    ZStack (alignment: .topLeading){
                        ARQuickLookView(fileName: "minuteasia_bobun", title: "Bobun", isPresented: self.$isPresented).edgesIgnoringSafeArea(.bottom)
                        HStack (alignment: .top){
                            VStack (alignment: .leading) {
                                Button(action: {
                                 self.isPresented = false
                                }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 25, weight: .light, design: .rounded))
                                    .padding(.horizontal, 19)
                                    .padding(.vertical, 12)
                                    .background(
                                        Blur(
                                             style: .systemThinMaterial)
                                        )
                                }).buttonStyle(PlainButtonStyle()).cornerRadius(14).padding(14)
                                .padding(.top, 11)
                             }
                         }
                    }
               }
            }
        }
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
