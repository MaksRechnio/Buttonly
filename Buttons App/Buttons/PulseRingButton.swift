import SwiftUI

// Button 13: Pulse Ring - Expanding ring sonar
struct PulseRingButton: View {
    @State private var isPressed = false
    @State private var rings: [PulseRing] = []
    @State private var idleRingScale: CGFloat = 1
    @State private var idleRingOpacity: Double = 0.3

    struct PulseRing: Identifiable {
        let id = UUID()
        var scale: CGFloat = 0.5
        var opacity: Double = 0.6
    }

    var body: some View {
        ZStack {
            // Idle pulse
            Circle()
                .stroke(Color(red: 0.3, green: 0.8, blue: 1).opacity(idleRingOpacity), lineWidth: 1.5)
                .frame(width: 130, height: 130)
                .scaleEffect(idleRingScale)

            // Burst rings
            ForEach(rings) { ring in
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(red: 0.3, green: 0.8, blue: 1),
                                Color(red: 0.1, green: 0.5, blue: 0.9)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 100, height: 100)
                    .scaleEffect(ring.scale)
                    .opacity(ring.opacity)
            }

            Button(action: {
                HapticManager.shared.impact(.medium)
                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                    isPressed = true
                }
                emitRings()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring(response: 0.3)) { isPressed = false }
                }
            }) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color(red: 0.3, green: 0.8, blue: 1),
                                    Color(red: 0.1, green: 0.4, blue: 0.9)
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 40
                            )
                        )
                        .frame(width: 80, height: 80)

                    Image(systemName: "dot.radiowaves.right")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                .shadow(color: Color(red: 0.3, green: 0.8, blue: 1).opacity(0.5), radius: 20)
                .scaleEffect(isPressed ? 0.85 : 1.0)
            }
        }
        .frame(width: 250, height: 250)
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                idleRingScale = 1.3
                idleRingOpacity = 0
            }
        }
    }

    private func emitRings() {
        for i in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.15) {
                var ring = PulseRing()
                ring.scale = 0.5
                ring.opacity = 0.6
                rings.append(ring)
                let ringId = ring.id

                withAnimation(.easeOut(duration: 0.8)) {
                    if let index = rings.firstIndex(where: { $0.id == ringId }) {
                        rings[index].scale = 2.5
                        rings[index].opacity = 0
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    rings.removeAll { $0.id == ringId }
                }
            }
        }
    }
}
