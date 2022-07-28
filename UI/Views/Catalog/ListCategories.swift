//
//  ListCategories.swift
//  TexnomartiOS
//
//  Created by yns on 04.04.2022.
//

import SwiftUI

struct ListCategories: View {
    @StateObject private var viewModel = CatalogViewModel()
    @Binding var idCategory: Int
    @Binding var titleCategory: String

    @State private var subCategoryID: Int = 0
    @State private var subCategoryTitle: String = ""
    @State private var isSubCategoryActive: Bool = false

    var body: some View {
        CustomNavBar(navTitle: titleCategory) {} content: {
            if viewModel.loadState == .loading {
                Spacer()
                CustomLoading()
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.listCategories) { list in
                        Button {
                            self.subCategoryID = list.id
                            self.subCategoryTitle = list.title
                            self.isSubCategoryActive = true
                        } label: {
                            ListRowContent(list: list)
                                .padding(.horizontal)
                                .padding(.top, 12)
                        }
                    }
                    .padding(.vertical, 12)
                }
                .background(
                    NavigationLink(
                        destination: LazyView(
                            SubCategoryView(
                                viewModel: viewModel, subCategoryTitle: $subCategoryTitle,
                                subCategoryID: $subCategoryID
                            )
                        ),
                        isActive: $isSubCategoryActive,
                        label: {
                            EmptyView()
                        }
                    )
                )
                .navigationBarHidden(true)
            }
        }
        .alert(isPresented: $viewModel.showPopup) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
        .onAppear {
            viewModel.getListCategories(categoryId: idCategory) {}
        }
    }
}

struct ListCategories_Previews: PreviewProvider {
    static var previews: some View {
        ListCategories(idCategory: .constant(1), titleCategory: .constant("Офисная техника"))
    }
}
