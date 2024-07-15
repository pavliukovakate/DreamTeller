//
//  ColorScheme.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import Foundation
import SwiftUI

enum ColorStyle {
    case pastel
    case earthTones
    case freshAndBright

    var colorSet: ColorSet {
        switch self {
        case .pastel:
            return ColorSet(
                backgroundColor: Asset.Colors.pastelBackground.swiftUIColor,
                accentColor: Asset.Colors.pastelAccent.swiftUIColor,
                iconColor: Asset.Colors.pastelIcon.swiftUIColor,
                textColor:  Asset.Colors.pastelText.swiftUIColor
            )
        
        case .earthTones:
            return ColorSet(
                backgroundColor: Color(red: 237/255, green: 224/255, blue: 212/255),
                accentColor: Color(red: 154/255, green: 97/255, blue: 109/255),
                iconColor: Color(red: 218/255, green: 165/255, blue: 32/255),
                textColor: Color(red: 92/255, green: 58/255, blue: 0/255)
            )
        
        case .freshAndBright:
            return ColorSet(
                backgroundColor: Color(red: 181/255, green: 234/255, blue: 215/255),
                accentColor: Color(red: 86/255, green: 180/255, blue: 233/255),
                iconColor: Color(red: 247/255, green: 240/255, blue: 82/255),
                textColor: Color(red: 65/255, green: 74/255, blue: 76/255)
            )
        }
    }
}

struct ColorSet {
    let backgroundColor: Color
    let accentColor: Color
    let iconColor: Color
    let textColor: Color
}
