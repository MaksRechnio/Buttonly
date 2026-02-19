import SwiftUI
import Combine

// Button 4: Liquid Morph - Organic blob shape animation
struct LiquidMorphButton: View {
    @State private var isPressed = false
    @State private var morphPhase: CGFloat = 0
    @State private var blobScale: CGFloat = 1
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
                isPressed = true
                blobScale = 1.15
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    isPressed = false
                    blobScale = 1
                }
            }
        }) {
            Text("Morph")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 160, height: 60)
                .background(
                    LiquidShape(phase: morphPhase)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1, green: 0.4, blue: 0.6),
                                    Color(red: 1, green: 0.6, blue: 0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .scaleEffect(blobScale)
                        .shadow(color: Color(red: 1, green: 0.4, blue: 0.6).opacity(0.5), radius: 20)
                )
        }
        .onReceive(timerPublisher) { _ in
            morphPhase += 0.03
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }
}

struct LiquidShape: Shape {
    var phase: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let cx = rect.midX
        let cy = rect.midY

        var path = Path()
        let points = 60
        let baseRadius = min(w, h) / 2

        for i in 0..<points {
            let angle = (CGFloat(i) / CGFloat(points)) * .pi * 2
            let wobble1 = sin(angle * 3 + phase * 2) * baseRadius * 0.12
            let wobble2 = cos(angle * 2 + phase * 1.5) * baseRadius * 0.08
            let wobble3 = sin(angle * 5 + phase * 3) * baseRadius * 0.04
            let r = baseRadius + wobble1 + wobble2 + wobble3

            let stretchX: CGFloat = 1.6
            let x = cx + cos(angle) * r * stretchX
            let y = cy + sin(angle) * r

            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}
