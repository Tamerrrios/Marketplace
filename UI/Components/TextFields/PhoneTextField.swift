//
//  PhoneTextField.swift
//  TexnomartiOS
//
//  Created by yns on 02.07.2022.
//

import SwiftUI

struct PhoneTextField: View {
    var title: String
    @Binding var phoneNumber: String
    var placeholder: String
    var alertText: String
    var onTap: () -> Void

    init(
        _ title: String,
        phoneNumber: Binding<String>,
        _ placeholder: String,
        alertText: String = "",
        onTap: @escaping () -> Void = {}
    ) {
        self.title = title
        _phoneNumber = phoneNumber
        self.placeholder = placeholder
        self.alertText = alertText
        self.onTap = onTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(title)
                .tracking(0.4)
                .robotoRegular(fontSize: 12, fontColor: .grayColor)

            TextField(placeholder, text: $phoneNumber)
                .keyboardType(.numberPad)
                .robotoRegular(fontSize: 14, fontColor: .blackGray)
                .padding(.top, 6)
            Divider()

            if !alertText.isEmpty {
                Text(alertText)
                    .foregroundColor(.red)
                    .font(.system(size: 12, weight: .light))
            }
        }
        .onChange(
            of: phoneNumber,
            perform: { newValue in
                DispatchQueue.main.async {
                    phoneNumber = newValue.applyPatternOnNumbers(pattern: "+### (##) ###-##-##", replacmentCharacter: "#")
                }
            }
        )
        .onAppear(perform: {
            onTap()
        })
        .padding(.top, 25.0)
    }
}

struct PhoneTextField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneTextField("Номер телефона", phoneNumber: .constant("+998936448111"), "Введите номер мобильного телефона")
    }
}
