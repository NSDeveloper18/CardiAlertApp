//
//  MyButtonStyle.swift
//  CardioAlert
//
//  Created by Shakhzod Botirov on 15/11/24.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 1 : 1)

            // You can also add other animated properties
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}
