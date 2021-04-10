//
//  DishDetailView.swift
//  ymenu-ios
//
//  Created by Léo GIGT on 20/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DishDetailView: View {
    var dish: Dish
    @State var isDownloading = false
    @State var isPresented = false
    @State var modelURL: String = "" {
        didSet {
            self.isPresented = true
        }
    }
    
    func checkUSDZExist(inputPath: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
          let url = NSURL(fileURLWithPath: path)
          if let pathComponent = url.appendingPathComponent(inputPath) {
              let filePath = pathComponent.path
              let fileManager = FileManager.default
              if fileManager.fileExists(atPath: filePath) {
                  print("File available, opening...")
                    return pathComponent.absoluteString
              } else {
                  print("File not available, downloading...")
                return ""
              }
          } else {
              print("File path not available")
            return ""
          }
    }
    
    func downloadUSDZ(inputURL: String) {
        let url = URL(string: inputURL)!
        let downloadTask = URLSession.shared.downloadTask(with: url) { urlOrNil, responseOrNil, errorOrNil in

         guard let fileURL = urlOrNil else { return }
            
         do {
             let documentsURL = try
                 FileManager.default.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false)
            let savedURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            self.modelURL = savedURL.absoluteString
            self.isDownloading = false
            print("Downloading done")
             try FileManager.default.moveItem(at: fileURL, to: savedURL)
       
         } catch {
             print ("file error: \(error)")
         }
     }
     downloadTask.resume()
    }
    
    init(dish: Dish) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name:"SF Pro Rounded Bold", size: 10)!
        ]
        
        self.dish = dish
    }

    var body: some View {
        let ingredients = dish.ingredients
        
        VStack(alignment: .leading) {
            ZStack {
                HStack {
                    List {
                        VStack(spacing: 0){
                            Spacer().padding(.bottom, 200)
                            HStack {
                                VStack(alignment: .leading, spacing: 4){
                                    HStack(spacing: 0){
                                        Text(dish.name)
                                        .padding(.top, 10)
                                        .padding(.bottom, 12)
                                        .padding(.leading, 10)
                                        .font(.custom("SF Pro Text Bold", fixedSize: 22))
                                        Spacer()
                                        Text("\(String(describing: dish.price))0 €")
                                        .padding(.top, 10)
                                        .padding(.bottom, 12)
                                        .padding(.trailing, 10)
                                        .font(.custom("SF Pro Text Regular", fixedSize: 20))
                                    }
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Blur(style: .systemThinMaterial))
                        }.listRowBackground(Color(UIColor.systemGray6)).listRowInsets(EdgeInsets())
                        .background(
                            WebImage(url: URL(string: dish.url_logo))
                              .onSuccess { image, data, cacheType in
                              }
                              .resizable()
                              .placeholder {
                                  Rectangle().foregroundColor(.gray)
                              }
                              .indicator(.activity)
                              .transition(.fade(duration: 0.5))
                                .aspectRatio(contentMode: .fill)
                                .frame(alignment: .top)
                                
                            )
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        Section() {
                            Text("Ingrédients")
                                .font(.custom("SF Pro Text Bold", fixedSize: 17))
                            ForEach(ingredients!, id: \.self) { ingredient in
                                Text(ingredient)
                                    .font(.custom("SF Pro Text Regular", fixedSize: 17))
                            }
                            .padding(.trailing, 5)
                        }
                        Section(header: Text("")) {}
                  
                   }.listStyle(InsetGroupedListStyle())
                }
                if (dish.url_model != ""){
                    Button(action: {
                        let fileName = URL(string: dish.url_model)?.lastPathComponent
                        let pathToUSDZ = checkUSDZExist(inputPath: fileName!)
                        if (pathToUSDZ != "") {
                            self.modelURL = pathToUSDZ
                        } else {
                            self.isDownloading = true
                            downloadUSDZ(inputURL: dish.url_model)
                        }
                    }) {
                    HStack {
                        if isDownloading {
                            ProgressView().padding(.horizontal, 3).progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            Text("Téléchargement...")
                                .bold()
                        } else {
                            Image(systemName: "arkit")
                            Text("Voir en RA")
                                .bold()
                        }
                    }}
                    .disabled(isDownloading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(.greatestFiniteMagnitude)
                    .sheet(isPresented: $isPresented) {
                        ZStack (alignment: .topLeading){
                            ARQuickLookView(filePath: self.$modelURL, title: dish.name, isPresented: self.$isPresented).edgesIgnoringSafeArea(.bottom)
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
                                    }).buttonStyle(PlainButtonStyle()).cornerRadius(14).padding(14).padding(.top, 11)
                                 }
                             }
                        }
                    }.shadow(radius: 5, x: 2, y: 2)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 20)
                    Spacer()
                }
            }
        }
        .navigationBarTitle(Text("Détails du produit"), displayMode: .automatic)
    }
}
