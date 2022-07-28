//
//  CatalogView.swift
//  TexnomartiOS
//
//  Created by yns on 30.03.2022.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    @State private var searchText: String = ""
    @State private var idListCategory: Int = 0
    @State private var titleListCategory: String = ""
    @State private var listIsActive: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Каталог")
                    .tracking(0.37)
                    .robotoBold(fontSize: 28, fontColor: .blackGray, fontWeight: .bold)
                    .frame(width: .displayWidth(90), alignment: .leading)
                    .padding(.vertical, 16)
                SearchBarView(searchText: $searchText)
                if viewModel.loadState == .loading {
                    Spacer()
                    CustomLoading()
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.mainCategories) { category in
                                Button {
                                    self.idListCategory = category.id
                                    self.titleListCategory = category.title
                                    self.listIsActive = true
                                } label: {
                                    listRowContent(category: category)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                        .padding(.vertical, 23)
                    }
                    .background(
                        NavigationLink(
                            destination: LazyView(
                                ListCategories(
                                    idCategory: $idListCategory,
                                    titleCategory: $titleListCategory
                                )
                            ),
                            isActive: $listIsActive,
                            label: {
                                EmptyView()
                            }
                        )
                    )
                }
            }
            .navigationBarHidden(true)
        }
        .alert(isPresented: $viewModel.showPopup) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
        .onAppear {
            viewModel.getAllMainCategories {}
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}

extension CatalogView {
    @ViewBuilder func listRowContent(category: MainCategoriesDataResponse) -> some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.lightGray)
                    .frame(width: 36, height: 36)

                ImageURL(url: "\(Consts.mainURL + category.mobileIcon)")
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipped()
            }

            Text(category.title)
                .tracking(0.1)
                .robotoMedium(fontSize: 14, fontWeight: .medium)

            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 7, height: 12)
                .foregroundColor(.gray)
                .font(.body)
        }
    }
}
