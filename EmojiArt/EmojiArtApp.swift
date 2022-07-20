//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Bijen Shrestha on 01/06/2022.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    let document = EmojiArtDocument()
    let palette = PaletteStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
