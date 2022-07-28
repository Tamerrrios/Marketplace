//
//  LoginViewModel.swift
//  TexnomartiOS
//
//  Created by yns on 02.07.2022.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @PhoneNumberPublished var phoneNumber: String = ""
    @Published var phoneMessage: String = ""
    @Published var phoneNumIsValid: Bool = false
    @Published var response: GetOtpCodeResponse = .init()

    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 4)

    private var cancellableSet: Set<AnyCancellable> = []

    @Published var loadState: LoadState = .notRequest
    @Published var errorMessage = ""
    @Published var showPopup: Bool = false
    private var repository: AnyCancellable?
}

extension LoginViewModel {
    func sendGetOtpCodeRequest(onSuccess: @escaping () -> Void) {
        loadState = .loading
        repository = UsersRepository.sharedManager.sendGetOtpCodeRequest(params: GetOtpCodeRequest(phone: phoneNumber)) { response in
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
            self?.response = result
            if result.success == true {
                onSuccess()
            }
        })
    }
}

extension LoginViewModel {
    func phoneNumberValidation() {
        $phoneNumber
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isValidPhone in
                guard let self = self else { return }
                self.phoneMessage = isValidPhone ? "" : "Введите номер мобильного телефона"
                self.phoneNumIsValid = isValidPhone
            })
            .store(in: &cancellableSet)
    }
}
