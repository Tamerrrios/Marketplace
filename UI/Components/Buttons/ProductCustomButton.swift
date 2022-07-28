//
//  ProductCustomButton.swift
//  TexnomartiOS
//
//  Created by yns on 26.03.2022.
//

import SwiftUI

struct ProductCustomButton: View {
    var buttonType: TypeEnum
    private var fontSize: CGFloat
    private var onTap: () -> Void

    init(
        buttonType: TypeEnum,
        fontSize: CGFloat = 11,
        onTap: @escaping () -> Void
    ) {
        self.buttonType = buttonType
        self.fontSize = fontSize
        self.onTap = onTap
    }

    var body: some View {
        Button {
            self.onTap()
        } label: {
            ZStack(alignment: .center) {
                switch buttonType {
                case .hasStores:
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.yellow, style: StrokeStyle(lineWidth: 2, lineCap: .square, dash: [5]))
                    Text(buttonType.title)
                        .tracking(0.5)
                        .multilineTextAlignment(.leading)
                        .robotoMedium(fontSize: fontSize, fontWeight: .medium)
                case .openToCart:
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.yellow)
                    Text(buttonType.title)
                        .tracking(0.5)
                        .robotoMedium(fontSize: fontSize, fontWeight: .medium)
                case .predzakaz:
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blackGray)
                    Text(buttonType.title)
                        .tracking(0.5)
                        .foregroundColor(.white)
                        .robotoMedium(fontSize: fontSize, fontWeight: .medium)
                case .notAvailable:
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.yellow)
                    Text(buttonType.title)
                        .tracking(0.5)
                        .robotoMedium(fontSize: fontSize, fontWeight: .medium)
                }
            }
            .frame(width: .isScreen4inch() ? .displayWidth(25) : .displayWidth(22), height: 32)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        ProductCustomButton(buttonType: .openToCart, fontSize: 12) {}
    }
}
