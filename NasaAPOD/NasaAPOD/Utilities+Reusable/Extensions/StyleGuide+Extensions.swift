//
//  Extensions.swift
//  Task2
//
//  Created by Mehboob Alam
//

import UIKit

/// Colors' exentions for making colors easy and multiple times to be used, each color Entity is self descriptive
extension UIColor {
    
    // This function returns a pre-defined UIColor for all kind of type strings that PokeAPI returns

    public convenience init?(hex: String?) {
        guard let hexString = hex else { return nil }
        
        let r, g, b: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                if hexColor.count == 6 {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
    static func random() -> UIColor {
        // generate any random color
        let red = CGFloat(arc4random_uniform(255) + 1)/255
        let blue = CGFloat(arc4random_uniform(255) + 1)/255
        let green = CGFloat(arc4random_uniform(255) + 1)/255
        return UIColor(red: red, green: blue, blue: green, alpha: 1.0)
    }

    static var lightBlueColor: UIColor {
        UIColor(red: 255/255, green: 151/255, blue: 152/255, alpha: 1)
    }

    static var appThemeColor: UIColor {
        UIColor(hex: "#2A63AE") ?? .blue.withAlphaComponent(0.7)
    }

    static var secondaryColor: UIColor {
        UIColor(hex: "#9BDAF1") ?? .cyan
    }
}

extension CGFloat {
    public static func minRelative(size: CGFloat) -> CGFloat {
        let ratio = (667/size) // iphone 7 is takken as refrence
        let relativeSize = (UIScreen.main.bounds.height/ratio)
        return minimum(relativeSize, size)
    }
}

