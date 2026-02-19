import SwiftUI

// Button 12: Cyber Glitch - Digital distortion flicker
struct CyberGlitchButton: View {
    @State private var isPressed = false
    @State private var glitching = false
    @State private var offsetR: CGFloat = 0
    @State private var offsetB: CGFloat = 0
    @State private var sliceOffset: CGFloat = 0
    @State private var flickerOpacity: Double = 1

    var body: some View {
        Button(action: {
            HapticManager.shared.notification(.warning)
            triggerGlitch()
        }) {
            ZStack {
                // Red channel offset
                Text("GLITCH")
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(.red.opacity(0.7))
                    .offset(x: offsetR, y: -offsetR * 0.5)

                // Blue channel offset
                Text("GLITCH")
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(.cyan.opacity(0.7))
                    .offset(x: offsetB, y: offsetB * 0.5)

                // Main text
                Text("GLITCH")
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.red.opacity(0.15),
                                        Color.clear,
                                        Color.cyan.opacity(0.15)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(
                        LinearGradient(
                            colors: [Color.red.opacity(0.5), Color.cyan.opacity(0.5)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 1
                    )
            )
            .offset(x: sliceOffset)
            .opacity(flickerOpacity)
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
    }

    private func triggerGlitch() {
        isPressed = true

        // Rapid glitch sequence
        for i in 0..<8 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.04) {
                withAnimation(.linear(duration: 0.03)) {
                    offsetR = CGFloat.random(in: -5...5)
                    offsetB = CGFloat.random(in: -5...5)
                    sliceOffset = CGFloat.random(in: -8...8)
                    flickerOpacity = Double.random(in: 0.7...1.0)
                }
            }
        }

        // Settle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.spring(response: 0.2)) {
                offsetR = 0
                offsetB = 0
                sliceOffset = 0
                flickerOpacity = 1
                isPressed = false
            }
        }
    }
}
