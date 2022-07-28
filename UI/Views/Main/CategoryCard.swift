//
//  CategoryCard.swift
//  TexnomartiOS
//
//  Created by yns on 21.03.2022.
//

import SwiftUI

struct CategoryCard: View {
    @StateObject private var viewModel = CatalogViewModel()
    @Binding var categories: [CategoryResponse]

    @State private var subCategoryID: Int = 0
    @State private var subCategoryTitle: String = ""
    @State private var isSubCategoryActive: Bool = false

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 24.0) {
                    ForEach(categories) { category in
                        Button {
                            self.subCategoryID = category.id
                            self.subCategoryTitle = category.title
                            self.isSubCategoryActive = true
                        } label: {
                            VStack(spacing: 8.0) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightGray)
                                        .frame(width: 80, height: 80)

                                    ImageURL(url: "\(Consts.mainURL + category.image)")
                                        .scaledToFit()
                                        .frame(width: .displayWidth(13.75), height: .displayHeight(7.75))
                                }
                                Text(category.title)
                                    .robotoRegular(fontSize: 12, fontColor: .blackGray)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .background(
                    NavigationLink(
                        destination: LazyView(
                            SubCategoryGridView(
                                viewModel: viewModel,
                                subCategoryGridID: $subCategoryID,
                                categoryGridTitle: $subCategoryTitle
                            )
                        ),
                        isActive: $isSubCategoryActive,
                        label: {
                            EmptyView()
                        }
                    )
                )
            }
        }
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(categories: .constant([CategoryResponse(image: "", title: "Смартфоны")]))
    }
}
