//
//  FavouriteDialog.swift
//  TexnomartiOS
//
//  Created by yns on 04.05.2022.
//

import SwiftUI

struct FavouriteDialog: View {
    @Binding var showFavouriteDialog: Bool
    @Binding var showFavouriteView: Bool

    var body: some View {
        HStack {
            Text("Товар теперь в \nизбранном")
                .tracking(0.1)
                .robotoMedium(fontSize: 14, fontWeight: .medium)

            Spacer()
            Button {
                withAnimation(.spring()) {
                    showFavouriteView = true
                }
            } label: {
                Text("В избранное")
                    .tracking(0.5)
                    .robotoMedium(fontSize: 14, fontWeight: .medium)
                    .foregroundColor(.blackGray)
                    .frame(width: 132, height: 32)
                    .background(Color.yellow)
                    .cornerRadius(6)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.showFavouriteDialog = false
                }
            }
        }
        .frame(width: .displayWidth(80), height: 64)
        .padding()
        .transition(.move(edge: .bottom))
    }
}

struct FavouriteDialog_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteDialog(showFavouriteDialog: .constant(false), showFavouriteView: .constant(false))
    }
}
