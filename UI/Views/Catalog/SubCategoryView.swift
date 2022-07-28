//
//  SubCategoryView.swift
//  TexnomartiOS
//
//  Created by yns on 06.04.2022.
//

import SwiftUI

struct SubCategoryView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @Binding var subCategoryTitle: String
    @Binding var subCategoryID: Int

    @State private var categoryID: Int = 0
    @State private var categoryTitle: String = ""
    @State private var categoryActive: Bool = false

    var body: some View {
        CustomNavBar(navTitle: subCategoryTitle) {
            if viewModel.loadState == .loading {
                Spacer()
                CustomLoading()
                Spacer()
            } else {
                Group {
                    if viewModel.listCategories.map { $0.id }.isEmpty {
                        CatalogEmpty()
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(viewModel.listCategories) { list in
                                Button {
                                    self.categoryID = list.id
                                    self.categoryTitle = list.title
                                    self.categoryActive = true
                                } label: {
                                    ListRowContent(list: list)
                                        .padding(.horizontal)
                                        .padding(.top, 12)
                                }
                            }
                            .padding(.vertical, 12)
                        }
                    }
                }
                .background(
                    NavigationLink(
                        destination: LazyView(
                            SubCategoryGridView(
                                viewModel: viewModel,
                                subCategoryGridID: $categoryID,
                                categoryGridTitle: $categoryTitle
                            )
                        ),
                        isActive: $categoryActive,
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
            viewModel.getListCategories(categoryId: subCategoryID) {}
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    @State static var viewModel = CatalogViewModel()

    static var previews: some View {
        SubCategoryView(
            viewModel: viewModel,
            subCategoryTitle: .constant("Телевизоры"),
            subCategoryID: .constant(2)
        )
    }
}
