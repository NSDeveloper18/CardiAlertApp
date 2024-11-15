//
//  HideKeyboard.swift
//  CardiAlertApp
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
