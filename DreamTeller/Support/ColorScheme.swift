//
//  ColorScheme.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import Foundation
import SwiftUI

struct ColorSet {
    var background: Color
    var primaryText: Color
    var secondaryText: Color
    var accent: Color
    var highlight: Color
    var buttonBackground: Color
    var buttonTextColor: Color
}

enum ColorPalette {
    case pastel
    case earthTones
    case freshAndBright
    case fairyTale
    case marine  // Добавляем новую палитру

    var colorSet: ColorSet {
        switch self {
        case .pastel:
            return ColorSet(
                background: Color("adaptivePastelBackground"),
                primaryText: Color("adaptivePastelPrimaryText"),
                secondaryText: Color("adaptivePastelSecondaryText"),
                accent: Color("adaptivePastelAccentColor"),
                highlight: Color("adaptivePastelHighlightColor"),
                buttonBackground: Color("adaptivePastelButtonBackground"),
                buttonTextColor: Color("adaptivePastelButtonTextColor")
            )
        case .earthTones:
            return ColorSet(
                background: Color("adaptiveEarthTonesBackground"),
                primaryText: Color("adaptiveEarthTonesPrimaryText"),
                secondaryText: Color("adaptiveEarthTonesSecondaryText"),
                accent: Color("adaptiveEarthTonesAccentColor"),
                highlight: Color("adaptiveEarthTonesHighlightColor"),
                buttonBackground: Color("adaptiveEarthTonesButtonBackground"),
                buttonTextColor: Color("adaptiveEarthTonesButtonTextColor")
            )
        case .freshAndBright:
            return ColorSet(
                background: Color("adaptiveFreshAndBrightBackground"),
                primaryText: Color("adaptiveFreshAndBrightPrimaryText"),
                secondaryText: Color("adaptiveFreshAndBrightSecondaryText"),
                accent: Color("adaptiveFreshAndBrightAccentColor"),
                highlight: Color("adaptiveFreshAndBrightHighlightColor"),
                buttonBackground: Color("adaptiveFreshAndBrightButtonBackground"),
                buttonTextColor: Color("adaptiveFreshAndBrightButtonTextColor")
            )
        case .fairyTale:
            return ColorSet(
                background: Color("adaptiveFairyTaleBackground"),
                primaryText: Color("adaptiveFairyTalePrimaryText"),
                secondaryText: Color("adaptiveFairyTaleSecondaryText"),
                accent: Color("adaptiveFairyTaleAccentColor"),
                highlight: Color("adaptiveFairyTaleHighlightColor"),
                buttonBackground: Color("adaptiveFairyTaleButtonBackground"),
                buttonTextColor: Color("adaptiveFairyTaleButtonTextColor")
            )
        case .marine:
            return ColorSet(
                background: Color("adaptiveMarineBackground"),
                primaryText: Color("adaptiveMarinePrimaryText"),
                secondaryText: Color("adaptiveMarineSecondaryText"),
                accent: Color("adaptiveMarineAccentColor"),
                highlight: Color("adaptiveMarineHighlightColor"),
                buttonBackground: Color("adaptiveMarineButtonBackground"),
                buttonTextColor: Color("adaptiveMarineButtonTextColor")
            )
        }
    }
}
