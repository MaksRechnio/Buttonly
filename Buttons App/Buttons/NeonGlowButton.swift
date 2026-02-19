import SwiftUI
import Combine

// Button 1: Neon Glow - Cyberpunk pulsating neon border
struct NeonGlowButton: View {
    @State private var isPressed = false
    @State private var glowPhase: CGFloat = 0
    @State private var borderGlow: CGFloat = 0
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    private let neonCyan = Color(red: 0, green: 1, blue: 0.8)
    private let neonPurple = Color(red: 0.5, green: 0, blue: 1)

    var body: some View {
        Button(action: handleTap) {
            buttonLabel
        }
        .onReceive(timerPublisher) { _ in
            glowPhase += 0.05
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                borderGlow = 1
            }
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }

    private var buttonLabel: some View {
        Text("ACTIVATE")
            .font(.system(size: 20, design: .monospaced).weight(.black))
            .tracking(6)
            .foregroundColor(neonCyan)
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.black.opacity(0.8))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(
                        LinearGradient(
                            colors: [neonCyan, neonPurple, neonCyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(color: neonCyan.opacity(0.6), radius: 15 + borderGlow * 20, y: 0)
            .shadow(color: neonPurple.opacity(0.4), radius: 25 + borderGlow * 15, y: 0)
            .scaleEffect(isPressed ? 0.92 : 1.0)
    }

    private func handleTap() {
        HapticManager.shared.complexPattern()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.4)) { isPressed = false }
        }
    }
}
