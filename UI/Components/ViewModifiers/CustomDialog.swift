//
//  CustomDialog.swift
//  TexnomartiOS
//
//  Created by yns on 04.05.2022.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    let dialogContent: DialogContent

    init(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: () -> DialogContent
    ) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
    }

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            if isShowing {
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white))
                        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 0)
                }
                .padding(.vertical)
            }
        }
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
    }
}
