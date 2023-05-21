//
//  UIColor+EXT.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

extension UIColor {
    static func getColor(index: Int) -> UIColor {
        switch index % 8 {
        case 0:
            return .blue
        case 1:
            return .systemGreen
        case 2:
            return .systemCyan
        case 3:
            return .systemTeal
        case 4:
            return .systemPink
        case 5:
            return .systemOrange
        case 6:
            return .systemPurple
        case 7:
            return .systemRed
        default:
            return .white
        }
    }
}
