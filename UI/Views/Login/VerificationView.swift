//
//  VerificationView.swift
//  TexnomartiOS
//
//  Created by yns on 03.07.2022.
//

import SwiftUI

enum OTPField {
    case field1
    case field2
    case field3
    case field4
}

struct VerificationView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState var activeField: OTPField?
    @State private var timeRemaining = 1 * 60
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        CustomNavBar(navTitle: "", callback: {}, content: {
            VStack {
                VStack(spacing: 8.0) {
                    Text("Введите код, отправленный на")
                        .tracking(0.25)
                        .robotoRegular(fontSize: 15, fontColor: .grayText)
                        .frame(width: .displayWidth(100), alignment: .center)

                    Text(viewModel.phoneNumber)
                        .tracking(0.25)
                        .robotoMedium(fontSize: 14, fontWeight: .medium)
                        .frame(width: .displayWidth(100), alignment: .center)
                }
                .padding(.vertical, 50)

                OTPField()

                VStack {
                    Text("Отправить новый код через \(timeString(time: timeRemaining))")
                        .tracking(0.4)
                        .multilineTextAlignment(.center)
                        .robotoRegular(fontSize: 13, fontColor: .grayText)
                        .padding(.bottom, 16)
                        .onReceive(timer) { _ in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            } else {
                                self.timer.upstream.connect().cancel()
                            }
                        }

                    Button(action: {}, label: {
                        Text("Отправить новый код")
                            .tracking(0.4).multilineTextAlignment(.center)
                            .robotoRegular(fontSize: 13, fontColor: .blue)
                    })
                    .padding(.bottom, 40)

                    XButton(title: "Подтвердить") {}
                }
                .padding(.top, 50)

                Spacer()
            }
            .onChange(of: viewModel.otpFields) { newValue in
                OTPCondition(value: newValue)
            }
        }, showSearchButton: false).navigationBarHidden(true)
    }

    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    @ViewBuilder
    func OTPField() -> some View {
        HStack(spacing: 14) {
            ForEach(0 ..< 4, id: \.self) { index in
                VStack(spacing: 8) {
                    TextField("", text: $viewModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                        .overlay(
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(viewModel.otpFields[index].isEmpty ? .gray.opacity(0.4) : .clear)
                        )

                    Rectangle()
                        .fill(activeField == activeStateForIndex(index: index) ? .yellow : .gray.opacity(0.3))
                        .frame(height: 3)
                }
                .frame(width: 40)
            }
        }
    }

    func OTPCondition(value: [String]) {
        // Moving next field if current field type
        for index in 0 ..< 3 {
            if value[index].count == 1, activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }

        // moving back if current is empty and previous is not empty
        for index in 1 ... 3 {
            if value[index].isEmpty, !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }

        for index in 0 ..< 4 {
            if value[index].count > 1 {
                viewModel.otpFields[index] = String(value[index].last!)
            }
        }
    }

    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    @StateObject static var viewModel = LoginViewModel()

    static var previews: some View {
        VerificationView(viewModel: viewModel)
    }
}
