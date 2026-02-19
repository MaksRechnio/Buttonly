import SwiftUI

// Button 18: Typewriter - Mechanical key clack with typing animation
struct TypewriterButton: View {
    @State private var isPressed = false
    @State private var displayText = ""
    @State private var isTyping = false
    @State private var cursorVisible = true

    let fullText = "CLICK ME"
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.rigid)
            triggerTypewriter()
        }) {
            HStack(spacing: 0) {
                Text(displayText)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(red: 0.95, green: 0.9, blue: 0.8))

                Rectangle()
                    .fill(Color(red: 0.95, green: 0.9, blue: 0.8))
                    .frame(width: 2, height: 22)
                    .opacity(cursorVisible ? 1 : 0)

                // Spacer to maintain width
                Text(String(repeating: " ", count: max(0, fullText.count - displayText.count)))
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(
                ZStack {
                    // Typewriter key appearance
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.3, green: 0.28, blue: 0.24),
                                    Color(red: 0.22, green: 0.2, blue: 0.17)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    // Key edge shadow
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.4, green: 0.35, blue: 0.28), lineWidth: 2)
                        .offset(y: isPressed ? 0 : -2)
                }
            )
            .offset(y: isPressed ? 3 : 0)
            .shadow(color: .black.opacity(0.4), radius: isPressed ? 2 : 5, y: isPressed ? 1 : 4)
        }
        .onAppear {
            displayText = fullText
        }
        .onReceive(timer) { _ in
            if !isTyping {
                cursorVisible.toggle()
            }
        }
    }

    private func triggerTypewriter() {
        guard !isTyping else { return }
        isTyping = true
        displayText = ""
        cursorVisible = true

        withAnimation(.spring(response: 0.1, dampingFraction: 0.5)) {
            isPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring(response: 0.15)) { isPressed = false }
        }

        for (index, char) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.08 + 0.2) {
                displayText += String(char)
                HapticManager.shared.impact(.light)

                // Small press animation for each character
                withAnimation(.spring(response: 0.05, dampingFraction: 0.3)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.spring(response: 0.1)) { isPressed = false }
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Double(fullText.count) * 0.08 + 0.3) {
            isTyping = false
        }
    }
}
