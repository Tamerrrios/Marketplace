//
//  ProfileListRow.swift
//  TexnomartiOS
//
//  Created by yns on 08.06.2022.
//

import SwiftUI

struct ProfileListRow: View {
    var profile: ProfileFirstFeatures

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                Image(profile.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .clipped()

                Text(profile.title)
                    .tracking(0.1)
                    .robotoRegular(fontSize: 14, fontColor: .blackGray)

                Spacer()
                if profile.showLang {
                    Text("O'z")
                        .tracking(0.1)
                        .robotoRegular(fontSize: 14, fontColor: .blackGray)
                }
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 7, height: 12)
                    .foregroundColor(.gray)
                    .font(.body)
            }
            Divider()
                .padding(.vertical, 6)
        }
        .padding(.horizontal, 16)
    }
}

struct ProfileListRow_Previews: PreviewProvider {
    @State static var firstProfileFeautures = ProfileFirstFeatures()

    static var previews: some View {
        ProfileListRow(profile: firstProfileFeautures)
    }
}
