//
//  UtilityExtension.swift
//  EmojiArt
//
//  Created by Bijen Shrestha on 02/06/2022.
//

import SwiftUI

extension Collection where Element: Identifiable {
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id})
    }
}


extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}


extension Array where Element == NSItemProvider {
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        if let provider = first(where: { $0.canLoadObject(ofClass: theType)}) {
            provider.loadObject(ofClass: theType) { object, error in
                if let value = object as? T {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T:
    _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading{
        if let provider = first(where: { $0.canLoadObject(ofClass: theType)}) {
            let _ = provider.loadObject(ofClass: theType) { object, error in
                if let value = object {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    
    func loadFirstObject<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        loadObjects(ofType: theType, firstOnly: true, using: load)
    }
    
    func loadFirstObject<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T:
    _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading{
        loadObjects(ofType: theType, firstOnly: true, using: load)
    }
}


extension Character {
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}


extension URL {
    var imageUrl: URL {
        for query in query?.components(separatedBy: "&") ?? [] {
            let queryComponents = query.components(separatedBy: "=")
            if queryComponents.count == 2 {
                if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") {
                    return url
                }
            }
        }
        return baseURL ?? self
    }
}

extension CGSize {
    var center: CGPoint {
        CGPoint( x: width/2, y: height/2 )
    }
        
        static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
            CGSize( width: lhs.width + rhs.width,
                    height: lhs.height + rhs.height )
        }
        
        static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
            CGSize( width: lhs.width - rhs.width,
                    height: lhs.height - rhs.height )
        }
        
        static func *(lhs: CGSize, multiplier: CGFloat) -> CGSize {
            CGSize( width: lhs.width * multiplier,
                    height: lhs.height * multiplier )
        }
        
        static func /(lhs: CGSize, divider: CGFloat) -> CGSize {
            CGSize( width: lhs.width / divider,
                    height: lhs.height / divider)
        }
}
