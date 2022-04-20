//
//  EditInfoProfilViewModel.swift
//  ymenu-ios
//
//  Created by Léo on 20/04/2022.
//

import Foundation
import SwiftUI

final class EditInfoProfilViewModel : ObservableObject {
    @Published var image: UIImage = UIImage()
    
    init() {
        if UserDefaults.standard.string(forKey: "profilImage") != nil {
            do {
                let url = URL(string: UserDefaults.standard.string(forKey: "profilImage")!)
                let data = try? Data(contentsOf: url!)
                image = UIImage(data: data!)!
            }
        } else {
            image = UIImage(systemName: "person.crop.circle")!
        }
    }
}
