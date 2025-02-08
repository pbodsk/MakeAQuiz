import Foundation
import SwiftUI

public struct WideButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color(.btnText))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.btnBackground), in: Capsule())
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension ButtonStyle where Self == WideButtonStyle {

    @MainActor @preconcurrency public static var wide: WideButtonStyle {
        return WideButtonStyle()
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(.wide)
}

