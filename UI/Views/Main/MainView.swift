//
//  MainView.swift
//  TexnomartiOS
//
//  Created by yns on 18.03.2022.
//

import SwiftUI

struct MainView: View {
    @Binding var catalogTab: Tab
    @StateObject private var viewModel = MainViewModel()
    @State private var searchText: String = ""
    @Namespace var namespace
    @State private var isHideLogo = false
    @State private var showFavouriteDialog = false
    @State private var showFavouriteView: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                TopHeader(searchText: $viewModel.searchText, isHideLogo: $isHideLogo)
                if viewModel.mainLoadState == .loading {
                    Spacer()
                    CustomLoading()
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        GeometryReader { reader -> AnyView in
                            let yAxis = reader.frame(in: .global).minY

                            if yAxis < 0 && !isHideLogo {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        isHideLogo = true
                                    }
                                }
                            }

                            if yAxis > 0 && isHideLogo {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        isHideLogo = false
                                    }
                                }
                            }

                            return AnyView(
                                Text("")
                                    .frame(width: 0, height: 0)
                            )
                        }
                        .frame(width: 0, height: 0)
                        .border(.red, width: 2)

                        sliderView()
                        VStack(spacing: 16.0) {
                            Header(title: "Категории", callback: {
                                withAnimation(.spring()) {
                                    self.catalogTab = .catalog
                                }
                            }) {
                                CategoryCard(categories: $viewModel.dataCategories)
                            }
                            .padding(.bottom, 16)
                            if !viewModel.newProducts.isEmpty {
                                Header(title: "Товары дня") {
                                    ProductCard(
                                        products: $viewModel.newProducts,
                                        namespace: namespace,
                                        showFavouriteDialog: $showFavouriteDialog
                                    )
                                }
                            }
                            Divider()
                                .padding(.leading, 16)
                            Header(title: "Хиты продаж") {
                                ProductCard(
                                    products: $viewModel.hitProducts,
                                    namespace: namespace,
                                    showFavouriteDialog: $showFavouriteDialog
                                )
                            }
                            Divider()
                                .padding(.leading, 16)
                            Header(title: "Просмотренные") {
                                ProductCard(
                                    products: $viewModel.recentlyProducts,
                                    namespace: namespace,
                                    showFavouriteDialog: $showFavouriteDialog
                                )
                            }
                            Divider()
                                .padding(.leading, 16)
                            ForEach($viewModel.specialCategoryProducts) { specialCategory in
                                Header(title: specialCategory.title.wrappedValue) {} content: {
                                    ProductCard(
                                        products: specialCategory.items,
                                        namespace: namespace,
                                        showFavouriteDialog: $showFavouriteDialog
                                    )
                                }
                                Divider()
                                    .padding(.leading, 16)
                            }

                            Header(title: "Популярные товары") {
                                ProductCard(
                                    products: $viewModel.recommendedProducts,
                                    axis: .vertical,
                                    scrollCase: .lazyVGrid,
                                    namespace: namespace,
                                    showFavouriteDialog: $showFavouriteDialog
                                    
                                )
                            }
                            .padding(.bottom, 100)
                            
                            
                        }
    
                    }
                }
            }
            .background(
                NavigationLink(destination: FavouriteView(), isActive: $showFavouriteView, label: {
                    EmptyView()
                })
            )
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.getMainInfo {}
            viewModel.viewedProducts {}
        }
        .alert(isPresented: $viewModel.showPopup) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
        .customDialog(isShowing: $showFavouriteDialog) {
            FavouriteDialog(showFavouriteDialog: $showFavouriteDialog, showFavouriteView: $showFavouriteView)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(catalogTab: .constant(.catalog))
    }
}

// MARK: - Slider

extension MainView {
    @ViewBuilder func sliderView() -> some View {
        if viewModel.dataSlider.count > 0 {
            TabView {
                ForEach(viewModel.dataSlider) { slider in
                    GeometryReader { geometry in
                        let grHeight = geometry.size.height
                        ImageURL(url: "\(Consts.mainURL + slider.image)")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: grHeight - 30, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                            .frame(width: geometry.size.width, height: grHeight - 30, alignment: .top)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: .isScreen4inch() ? .displayHeight(31.26) : .displayHeight(28))
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.colorYellow)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor(.grayColor)
            }
        }
    }
}
