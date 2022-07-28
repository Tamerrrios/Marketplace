//
//  RobotoFontModifier.swift
//  TexnomartiOS
//
//  Created by yns on 17.03.2022.
//

import SwiftUI

struct RobotoFontModifier: ViewModifier {
    var size: CGFloat
    var fontColor: Color = .blackGray
    var weight: Font.Weight = .regular
    var fontTitle: String = "Roboto-Regular"

    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontTitle, size: size)
                .weight(weight))
            .foregroundColor(fontColor)
    }
}

extension View {
    func robotoRegular(fontSize: CGFloat, fontColor: Color) -> some View {
        modifier(RobotoFontModifier(size: fontSize, fontColor: fontColor))
    }

    func robotoMedium(fontSize: CGFloat, fontWeight: Font.Weight) -> some View {
        modifier(RobotoFontModifier(size: fontSize, weight: fontWeight, fontTitle: "Roboto-Medium"))
    }

    func robotoBold(fontSize: CGFloat, fontColor: Color, fontWeight: Font.Weight) -> some View {
        modifier(RobotoFontModifier(size: fontSize, fontColor: fontColor, weight: fontWeight, fontTitle: "Roboto-Bold"))
    }
}
