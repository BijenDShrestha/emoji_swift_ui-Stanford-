//
//  UtilityViews.swift
//  EmojiArt
//
//  Created by Bijen Shrestha on 10/06/2022.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        if uiImage != nil {
            Image(uiImage: uiImage!)
        }
    }
}
