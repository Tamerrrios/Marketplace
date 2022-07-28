//
//  XButton.swift
//  TexnomartiOS
//
//  Created by yns on 16.05.2022.
//

import SwiftUI

struct XButton: View {
    var title: String
    var btnWithStroke: Bool
    private var onTap: () -> Void

    init(
        title: String,
        btnWithStroke: Bool = false,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.btnWithStroke = btnWithStroke
        self.onTap = onTap
    }

    var body: some View {
        Button {
            self.onTap()
        } label: {
            ZStack(alignment: .center) {
                if btnWithStroke {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.colorYellow, style: StrokeStyle(lineWidth: 2))
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.colorYellow)
                }
                Text(title)
                    .robotoMedium(fontSize: 14, fontWeight: .medium)
            }
            .frame(width: .displayWidth(90), height: 41)
        }
    }
}

struct XButton_Previews: PreviewProvider {
    static var previews: some View {
        XButton(title: "Войти", btnWithStroke: true, onTap: {})
    }
}
