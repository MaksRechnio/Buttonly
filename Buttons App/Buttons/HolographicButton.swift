import SwiftUI
import Combine

// Button 17: Holographic - Rainbow foil iridescence
struct HolographicButton: View {
    @State private var isPressed = false
    @State private var hueRotation: Double = 0
    @State private var tiltX: CGFloat = 0
    @State private var tiltY: CGFloat = 0
    @State private var shimmerPhase: CGFloat = 0
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
            Text("Holo")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 44)
                .padding(.vertical, 18)
                .background(
                    ZStack {
                        // Base
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(red: 0.15, green: 0.1, blue: 0.2))

                        // Holographic gradient
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                AngularGradient(
                                    colors: [
                                        Color.red.opacity(0.4),
                                        Color.orange.opacity(0.4),
                                        Color.yellow.opacity(0.4),
                                        Color.green.opacity(0.4),
                                        Color.cyan.opacity(0.4),
                                        Color.blue.opacity(0.4),
                                        Color.purple.opacity(0.4),
                                        Color.red.opacity(0.4)
                                    ],
                                    center: .center,
                                    startAngle: .degrees(hueRotation),
                                    endAngle: .degrees(hueRotation + 360)
                                )
                            )

                        // Shimmer overlay
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .white.opacity(0.2), .clear],
                                    startPoint: UnitPoint(x: shimmerPhase - 0.3, y: 0),
                                    endPoint: UnitPoint(x: shimmerPhase, y: 1)
                                )
                            )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(
                            AngularGradient(
                                colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .red],
                                center: .center,
                                startAngle: .degrees(hueRotation),
                                endAngle: .degrees(hueRotation + 360)
                            ),
                            lineWidth: 1.5
                        )
                        .opacity(0.6)
                )
                .rotation3DEffect(
                    .degrees(tiltX * 5),
                    axis: (x: 0, y: 1, z: 0)
                )
                .rotation3DEffect(
                    .degrees(tiltY * 5),
                    axis: (x: 1, y: 0, z: 0)
                )
                .shadow(color: Color.purple.opacity(0.3), radius: 15)
                .scaleEffect(isPressed ? 0.93 : 1.0)
        }
        .onReceive(timerPublisher) { _ in
            shimmerPhase += 0.008
            if shimmerPhase > 1.5 { shimmerPhase = -0.5 }
            tiltX = sin(shimmerPhase * 4) * 1.5
            tiltY = cos(shimmerPhase * 3) * 1
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                hueRotation = 360
            }
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }
}
