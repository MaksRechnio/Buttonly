import SwiftUI
import Combine

// Button 11: Aurora Borealis - Northern lights shimmer
struct AuroraBorealisButton: View {
    @State private var isPressed = false
    @State private var hueRotation: Double = 0
    @State private var wavePhase: CGFloat = 0
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4)) { isPressed = false }
            }
        }) {
            Text("Aurora")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 44)
                .padding(.vertical, 18)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.black.opacity(0.3))

                        // Aurora layers
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0, green: 0.9, blue: 0.6).opacity(0.6),
                                        Color(red: 0.2, green: 0.4, blue: 0.9).opacity(0.6),
                                        Color(red: 0.5, green: 0.1, blue: 0.8).opacity(0.6),
                                        Color(red: 0, green: 0.8, blue: 0.5).opacity(0.6)
                                    ],
                                    startPoint: UnitPoint(x: wavePhase, y: 0),
                                    endPoint: UnitPoint(x: wavePhase + 0.5, y: 1)
                                )
                            )
                            .hueRotation(.degrees(hueRotation))

                        // Light streaks
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .white.opacity(0.1), .clear],
                                    startPoint: UnitPoint(x: wavePhase * 2, y: 0),
                                    endPoint: UnitPoint(x: wavePhase * 2 + 0.3, y: 1)
                                )
                            )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.white.opacity(0.15), lineWidth: 1)
                )
                .shadow(color: Color(red: 0, green: 0.8, blue: 0.5).opacity(0.4), radius: 20)
                .scaleEffect(isPressed ? 0.93 : 1.0)
        }
        .onReceive(timerPublisher) { _ in
            wavePhase += 0.003
            if wavePhase > 1 { wavePhase = 0 }
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: true)) {
                hueRotation = 90
            }
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }
}
