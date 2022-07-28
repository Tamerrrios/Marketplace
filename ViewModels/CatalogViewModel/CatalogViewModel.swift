//
//  CatalogViewModel.swift
//  TexnomartiOS
//
//  Created by yns on 30.03.2022.
//

import Combine
import SwiftUI

class CatalogViewModel: ObservableObject {
    @Published var mainCategories: [MainCategoriesDataResponse] = []
    @Published var listCategories: [ListCategoriesDataResponse] = []
    @Published var categoryProductItems: [HitProductResponse] = []

    @Published var productFavourites: Set<String> = []
    let defaults = UserDefaults.standard

    @Published var loadState: LoadState = .notRequest
    @Published var errorMessage = ""
    @Published var showPopup: Bool = false
    private var catalog: AnyCancellable?
}

extension CatalogViewModel {
    func getAllMainCategories(onSuccess: @escaping () -> Void) {
        loadState = .loading
        catalog = CatalogRepository.sharedManager.getAllMainCategories { response in
            if response == nil {
            } else {
                self.errorMessage = Utils.jsonToUserError(from: response)
                self.showPopup = true
            }
        }
        .mapError { [weak self] error -> Error in
            self?.loadState = .error(self?.errorMessage ?? "ошибка")
            return error
        }
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            withAnimation(Animation.easeIn(duration: 1).delay(0.5)) {
                self?.loadState = .success
            }
            self?.errorMessage = ""
            self?.mainCategories = result.data
            onSuccess()
        })
    }

    func getListCategories(categoryId: Int, onSuccess: @escaping () -> Void) {
        loadState = .loading
        catalog = CatalogRepository.sharedManager.getListCategories(categoryId: categoryId) { response in
            if response == nil {
            } else {
                self.errorMessage = Utils.jsonToUserError(from: response)
                self.showPopup = true
            }
        }
        .mapError { [weak self] error -> Error in
            self?.loadState = .error(self?.errorMessage ?? "ошибка")
            return error
        }
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            withAnimation(Animation.easeIn(duration: 1).delay(0.5)) {
                self?.loadState = .success
            }
            self?.errorMessage = ""
            self?.listCategories = result.data
            onSuccess()
        })
    }
}

extension CatalogViewModel {
    func getCategoryProducts(subCategoryID: Int, onSuccess: @escaping () -> Void) {
        loadState = .loading
        catalog = CatalogRepository.sharedManager.getCategoryProducts(
            params: [
                "min-price": "0",
                "max-price": "5000000",
                "sort": "-popular",
                "filter": "[\"Samsung\",\"Apple\"]",
                "category_id": "\(subCategoryID.description)",
            ]
        ) { response in
            if response == nil {
            } else {
                self.errorMessage = Utils.jsonToUserError(from: response)
                self.showPopup = true
            }
        }
        .mapError { [weak self] error -> Error in
            self?.loadState = .error(self?.errorMessage ?? "ошибка")
            return error
        }
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            withAnimation(Animation.easeIn(duration: 1).delay(0.5)) {
                self?.loadState = .success
            }
            self?.errorMessage = ""
            self?.categoryProductItems = result.data.products.items
            onSuccess()
        })
    }
}

// MARK: - В будущем добавления в избранных можно убрать, т.к. добавлен бэк роут для этого

extension CatalogViewModel: FavouritesProtocol {
    func getProductsIds() -> Set<String> {
        return productFavourites
    }

    func contains(_ product: HitProductResponse) -> Bool {
        productFavourites.contains(product.id.description)
    }

    func add(_ product: HitProductResponse) {
        productFavourites.insert(product.id.description)
        save()
    }

    func remove(_ product: HitProductResponse) {
        productFavourites.remove(product.id.description)
        save()
    }

    func save() {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(categoryProductItems) {
            defaults.set(encoded, forKey: Consts.categoryProduct)
        }

        defaults.set(Array(productFavourites), forKey: Consts.favouriteProducts)
        defaults.synchronize()
    }
}
