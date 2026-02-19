import SwiftUI
import Combine

// Button 20: Gravity Float - Zero-G levitation with gentle bob
struct GravityFloatButton: View {
    @State private var isPressed = false
    @State private var floatY: CGFloat = 0
    @State private var shadowRadius: CGFloat = 10
    @State private var shadowY: CGFloat = 5
    @State private var rotation: Double = 0
    @State private var orbitAngle: Double = 0
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        ZStack {
            // Orbiting dots
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .fill(Color(red: 0.5, green: 0.7, blue: 1).opacity(0.4))
                    .frame(width: 4, height: 4)
                    .offset(
                        x: cos(orbitAngle + Double(i) * .pi / 2) * 70,
                        y: sin(orbitAngle + Double(i) * .pi / 2) * 25
                    )
            }

            Button(action: {
                HapticManager.shared.impact(.soft)
                triggerFloat()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up.and.down.circle.fill")
                        .font(.system(size: 20))
                        .rotationEffect(.degrees(rotation))
                    Text("Float")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 36)
                .padding(.vertical, 18)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.5, green: 0.7, blue: 1),
                                    Color(red: 0.3, green: 0.4, blue: 0.9)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color(red: 0.4, green: 0.5, blue: 1).opacity(0.4),
                        radius: shadowRadius, y: shadowY)
                .scaleEffect(isPressed ? 0.9 : 1.0)
            }
            .offset(y: floatY)
        }
        .frame(height: 120)
        .onReceive(timerPublisher) { _ in
            orbitAngle += 0.02
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
            // Gentle idle float
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                floatY = -8
                shadowRadius = 18
                shadowY = 12
            }
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }

    private func triggerFloat() {
        // Launch up
        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
            floatY = -30
            isPressed = true
            rotation = 360
        }

        // Float back down
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.5)) {
                floatY = 0
                isPressed = false
            }
        }

        // Resume idle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                floatY = -8
            }
        }
    }
}
