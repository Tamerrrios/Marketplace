//
//  SubCategoryTwoGridView.swift
//  TexnomartiOS
//
//  Created by yns on 29.06.2022.
//

import SwiftUI

struct SubCategoryTwoGridView: View {
    @ObservedObject var viewModel: CatalogViewModel
    let namespace: Namespace.ID
    @Binding var showFavouriteDialog: Bool

    private let gridItems = [
        GridItem(),
        GridItem(),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridItems, spacing: 16) {
                productCardContent
            }
            .padding(.horizontal, .isScreen4inch() ? 16 : 0)
        }
    }
}

struct SubCategoryTwoGridView_Previews: PreviewProvider {
    @State static var viewModel = CatalogViewModel()
    @Namespace static var namespace

    static var previews: some View {
        SubCategoryTwoGridView(viewModel: viewModel, namespace: namespace, showFavouriteDialog: .constant(false))
    }
}

extension SubCategoryTwoGridView {
    var productCardContent: some View {
        ForEach(viewModel.categoryProductItems) { product in
            VStack(spacing: 0) {
                ZStack {
                    ImageURL(url: "\(Consts.mainURL + product.image)")
                        .matchedGeometryEffect(id: "image", in: namespace, isSource: false)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: .displayWidth(24.53), height: .displayHeight(10), alignment: .center)
                        .clipped()
                }
                .frame(height: .displayHeight(10), alignment: .center)

                VStack(alignment: .leading, spacing: 0) {
                    Text(product.name)
                        .matchedGeometryEffect(id: "name", in: namespace, isSource: false)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .robotoRegular(fontSize: .isScreen4inch() ? 10.5 : 12, fontColor: .blackGray)
                        .padding(.vertical, 3)
                        .zIndex(1)

                    Rating(rating: product.reviewsMiddleRate, reviewsCount: product.reviewsCount)
                        .matchedGeometryEffect(id: "rating", in: namespace, isSource: false)
                        .padding(.bottom, 8)

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
                        .padding(.bottom, .isScreen4inch() ? 16 : 22)
                    }
                    .matchedGeometryEffect(id: "pricePart", in: namespace, isSource: false)
                }
            }
            .frame(
                width: .isScreen4inch() ? .displayWidth(45) : .displayWidth(36),
                height: .isScreen4inch() ? .displayHeight(42) : .displayHeight(32),
                alignment: .leading
            )
            .overlay(
                ZStack {
                    if let type = product.availability?.type {
                        ProductCustomButton(buttonType: type) {}
                            .matchedGeometryEffect(id: "btn", in: namespace, isSource: false)
                    }
                }, alignment: .bottomLeading
            )
            .overlay(
                ZStack {
                    if let key = product.stik?.key {
                        BadgeCard(key: key)
                            .matchedGeometryEffect(id: "badge", in: namespace, isSource: false)
                    }
                }, alignment: .topLeading
            )
            .overlay(
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
                            .renderingMode(.template)
                            .foregroundColor(.grayColor)
                            .frame(width: 18, height: 18)
                    })
                }
                .matchedGeometryEffect(id: "btns", in: namespace, isSource: false), alignment: .topTrailing
            )
        }
        .padding(.trailing, .isScreen4inch() ? 2 : 4)
    }
}
