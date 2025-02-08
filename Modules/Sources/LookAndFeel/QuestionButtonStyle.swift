import SwiftUI

public struct QuestionButtonStyle: ButtonStyle {
    var isSelected: Bool
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(isSelected ? Color(.quizBtnBackgroundSelected) : .clear, in: RoundedRectangle(cornerRadius: 8))
            .border(.black, width: 1)
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview("Not Selected") {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(QuestionButtonStyle(isSelected: false))
}

#Preview("Selected") {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(QuestionButtonStyle(isSelected: true))
}

extension ButtonStyle where Self == QuestionButtonStyle {

    @MainActor @preconcurrency public static var selectedQuestion: QuestionButtonStyle {
        return QuestionButtonStyle(isSelected: true)
    }

    @MainActor @preconcurrency public static var unselectedQuestion: QuestionButtonStyle {
        return QuestionButtonStyle(isSelected: false)
    }

}
