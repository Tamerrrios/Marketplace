//
//  SubCategoryGridView.swift
//  TexnomartiOS
//
//  Created by yns on 07.04.2022.
//

import SwiftUI

struct SubCategoryGridView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @State private var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @Namespace var namespace
    @State private var showFavouriteDialog = false
    @Binding var subCategoryGridID: Int
    @Binding var categoryGridTitle: String
    @State private var showFavouriteView: Bool = false

    var body: some View {
        CustomNavBar(navTitle: categoryGridTitle) {
            if viewModel.loadState == .loading {
                Spacer()
                CustomLoading()
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    FilterContent(columns: $columns)
                    VStack {
                        if columns.count == 2 {
                            /*
                             ProductCard(
                                 products: $viewModel.categoryProductItems,
                                 axis: .vertical,
                                 scrollCase: .lazyVGrid,
                                 namespace: namespace,
                                 showFavouriteDialog: $showFavouriteDialog
                             )
                              */
                            SubCategoryTwoGridView(viewModel: viewModel, namespace: namespace, showFavouriteDialog: $showFavouriteDialog)
                                .padding(.vertical, 16)

                        } else {
                            ForEach(viewModel.categoryProductItems) { product in
                                VStack(spacing: 15.0) {
                                    HStack(alignment: .top) {
                                        VStack(spacing: 0) {
                                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                                                ImageURL(url: "\(Consts.mainURL + product.image)")
                                                    .matchedGeometryEffect(id: "image", in: namespace, isSource: false)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: .displayWidth(26), height: .displayHeight(13), alignment: .center)
                                                    .clipped()

                                                if let key = product.stik?.key {
                                                    BadgeCard(key: key)
                                                        .matchedGeometryEffect(id: "badge", in: namespace, isSource: false)
                                                }
                                            }
                                            .frame(height: .displayHeight(13), alignment: .center)

                                            Rating(rating: product.reviewsMiddleRate, reviewsCount: product.reviewsCount)
                                                .matchedGeometryEffect(id: "rating", in: namespace, isSource: false)
                                                .padding(.bottom, 8)
                                        }

                                        VStack(alignment: .leading, spacing: 0) {
                                            Text(product.name)
                                                .matchedGeometryEffect(id: "name", in: namespace, isSource: false)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                                .robotoRegular(fontSize: .isScreen4inch() ? 10.5 : 12, fontColor: .blackGray)
                                                .padding(.vertical, 3)
                                                .zIndex(1)

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(product.fLoanPrice)
                                                    .strikethrough()
                                                    .robotoRegular(fontSize: .isScreen4inch() ? 10.5 : 12, fontColor: .grayText)

                                                Text(product.fSalePrice)
                                                    .robotoBold(
                                                        fontSize: .isScreen4inch() ? 12.5 : 14,
                                                        fontColor: .blackGray,
                                                        fontWeight: .bold
                                                    )

                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .foregroundColor(.lightGray)

                                                    Text(product.axiomMonthlyPrice)
                                                        .foregroundColor(.blackGray)
                                                        .robotoMedium(fontSize: .isScreen4inch() ? 8.5 : 10, fontWeight: .medium)
                                                }
                                                .frame(
                                                    width: .isScreen4inch() ? .displayWidth(38) : .displayWidth(32),
                                                    height: 17,
                                                    alignment: .center
                                                )
                                                .padding(.bottom, 16)
                                            }
                                            .matchedGeometryEffect(id: "pricePart", in: namespace, isSource: false)

                                            ZStack {
                                                if let type = product.availability?.type {
                                                    ProductCustomButton(buttonType: type) {}
                                                        .matchedGeometryEffect(id: "btn", in: namespace, isSource: false)
                                                }
                                            }
                                        }
                                        .padding(.leading, 16)
                                        Spacer()
                                        VStack(spacing: 12.0) {
                                            Button(action: {
                                                if viewModel.contains(product) {
                                                    viewModel.remove(product)
                                                } else {
                                                    viewModel.add(product)
                                                    showFavouriteDialog = true
                                                }
                                            }, label: {
                                                Image(systemName: viewModel.contains(product) ? "heart.fill" : "heart")
                                                    .foregroundColor(viewModel.contains(product) ? .red : .grayColor)
                                                    .frame(width: 18, height: 18)
                                            })

                                            Button(action: {}, label: {
                                                Image("scaleImage")
                                                    .foregroundColor(.grayColor)
                                                    .frame(width: 18, height: 18)
                                            })
                                        }
                                        .matchedGeometryEffect(id: "btns", in: namespace, isSource: false)
                                    }
                                    .padding([.horizontal, .top], 16)

                                    Divider()
                                        .padding(.horizontal, 16)
                                        .padding(.top, 8)
                                }
                            }
                        }
                    }
                }
            }
        }
        .customDialog(isShowing: $showFavouriteDialog) {
            FavouriteDialog(showFavouriteDialog: $showFavouriteDialog, showFavouriteView: $showFavouriteView)
        }
        .background(
            NavigationLink(destination: FavouriteView(), isActive: $showFavouriteView, label: {
                EmptyView()
            })
        )
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getCategoryProducts(subCategoryID: subCategoryGridID) {}
        }
    }
}

struct SubCategoryGridView_Previews: PreviewProvider {
    @State static var viewModel = CatalogViewModel()

    static var previews: some View {
        SubCategoryGridView(
            viewModel: viewModel,
            subCategoryGridID: .constant(0),
            categoryGridTitle: .constant("")
        )
    }
}
