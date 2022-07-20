//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by Bijen Shrestha on 01/06/2022.
//

import Foundation

struct EmojiArtModel: Codable {
    var background = Background.blank
    
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Hashable, Codable {
        var id: Int
        let text: String
        var x: Int //offset from center
        var y: Int //offset from center
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(EmojiArtModel.self, from: json)
    }
    
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try EmojiArtModel(json: data)
    }
    
    init() {}
    
    
    private var uniqueEmojiId = 0
    
    // location is tuple
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: location.x, y: location.y, size: size))
    }
    

}
