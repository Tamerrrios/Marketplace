//
//  MainViewModel.swift
//  TexnomartiOS
//
//  Created by yns on 23.03.2022.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var dataSlider: [SliderResponse] = []
    @Published var dataCategories: [CategoryResponse] = []
    @Published var newProducts: [HitProductResponse] = []
    @Published var hitProducts: [HitProductResponse] = []
    @Published var recentlyProducts: [HitProductResponse] = []
    @Published var recommendedProducts: [HitProductResponse] = []
    @Published var specialCategoryProducts: [SpecialCategoryProductResponse] = []

    @Published var productFavourites: Set<String> = []
    let defaults = UserDefaults.standard

    @Published var mainLoadState: LoadState = .notRequest
    @Published var viewedLoadState: LoadState = .notRequest // TODO: Не привязан в view
    @Published var errorMessage = ""
    @Published var showPopup: Bool = false

    @Published var searchText: String = ""

    private var home: AnyCancellable?
    private var viewedProducts: AnyCancellable?
}

extension MainViewModel {
    func getMainInfo(onSuccess: @escaping () -> Void) {
        mainLoadState = .loading
        home = MainRepository.sharedManager.getMainInfo { response in
            if response == nil {
            } else {
                self.errorMessage = Utils.jsonToUserError(from: response)
                self.showPopup = true
            }
        }
        .mapError { [weak self] error -> Error in
            self?.mainLoadState = .error(self?.errorMessage ?? "ошибка")
            return error
        }
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            guard let self = self else { return }
            withAnimation(.spring()) {
                self.mainLoadState = .success
            }
            DispatchQueue.main.async {
                self.errorMessage = ""
                self.dataSlider = result.data.slider
                self.dataCategories = result.data.categories
                self.newProducts = result.data.newProducts
                self.hitProducts = result.data.hitProducts
                self.recommendedProducts = result.data.recommendedProducts
                self.specialCategoryProducts = result.data.specialCategoryProducts

                self.productFavourites = Set(self.defaults.array(forKey: Consts.favouriteProducts) as? [String] ?? [])
            }
            onSuccess()
        })
    }
}

extension MainViewModel {
    func viewedProducts(onSuccess: @escaping () -> Void) {
        viewedLoadState = .loading
        viewedProducts = MainRepository.sharedManager.viewedProducts(params: ["95675", "88827"]) { response in
            if response == nil {
            } else {
                self.errorMessage = Utils.jsonToUserError(from: response)
                self.showPopup = true
            }
        }
        .mapError { [weak self] error -> Error in
            self?.viewedLoadState = .error(self?.errorMessage ?? "ошибка")
            return error
        }
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            withAnimation(.spring()) {
                self?.viewedLoadState = .success
            }
            self?.errorMessage = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.recentlyProducts = result.data
            }
            onSuccess()
        })
    }
}

// MARK: - В будущем добавления в избранных можно убрать, т.к. добавлен бэк роут для этого

extension MainViewModel: FavouritesProtocol {
    func getProductsIds() -> Set<String> {
        return productFavourites
    }

    func contains(_ product: HitProductResponse) -> Bool {
        productFavourites.contains(product.id.description)
    }

    func add(_ product: HitProductResponse) {
        productFavourites.insert(product.id.description)
        debugPrint("productFavourites add in MainViewModel: \(productFavourites.map { $0.debugDescription })")
        save()
    }

    func remove(_ product: HitProductResponse) {
        productFavourites.remove(product.id.description)
        save()
    }

    func save() {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(newProducts) {
            defaults.set(encoded, forKey: Consts.categoryProduct)
        }

        if let encoded = try? encoder.encode(hitProducts) {
            defaults.set(encoded, forKey: Consts.categoryProduct)
        }

        defaults.set(Array(productFavourites), forKey: Consts.favouriteProducts)
        defaults.synchronize()
    }
}
