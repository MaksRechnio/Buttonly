import SwiftUI
import Combine

// Button 19: Circuit Board - Tech pathway animation
struct CircuitBoardButton: View {
    @State private var isPressed = false
    @State private var traceProgress: CGFloat = 0
    @State private var glowOpacity: Double = 0.3
    @State private var circuitPhase: CGFloat = 0
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        Button(action: {
            HapticManager.shared.complexPattern()
            triggerCircuit()
        }) {
            ZStack {
                // Circuit traces
                Canvas { context, size in
                    let w = size.width
                    let h = size.height

                    // Draw circuit traces
                    let traces: [(CGPoint, CGPoint, CGPoint)] = [
                        (CGPoint(x: 0, y: h * 0.3), CGPoint(x: w * 0.3, y: h * 0.3), CGPoint(x: w * 0.3, y: 0)),
                        (CGPoint(x: w, y: h * 0.7), CGPoint(x: w * 0.7, y: h * 0.7), CGPoint(x: w * 0.7, y: h)),
                        (CGPoint(x: 0, y: h * 0.7), CGPoint(x: w * 0.2, y: h * 0.7), CGPoint(x: w * 0.2, y: h * 0.5)),
                        (CGPoint(x: w, y: h * 0.3), CGPoint(x: w * 0.8, y: h * 0.3), CGPoint(x: w * 0.8, y: h * 0.5)),
                    ]

                    for (i, trace) in traces.enumerated() {
                        var path = Path()
                        path.move(to: trace.0)
                        path.addLine(to: trace.1)
                        path.addLine(to: trace.2)

                        let progress = min(1, max(0, traceProgress - CGFloat(i) * 0.15))
                        let color = Color(red: 0, green: 1, blue: 0.5).opacity(Double(progress) * 0.6)
                        context.stroke(
                            path.trimmedPath(from: 0, to: progress),
                            with: .color(color),
                            lineWidth: 1.5
                        )

                        // Node dots
                        if progress > 0.5 {
                            let dot = Path(ellipseIn: CGRect(
                                x: trace.1.x - 3, y: trace.1.y - 3, width: 6, height: 6
                            ))
                            context.fill(dot, with: .color(Color(red: 0, green: 1, blue: 0.5).opacity(Double(progress))))
                        }
                    }
                }

                HStack(spacing: 10) {
                    Image(systemName: "cpu.fill")
                        .font(.system(size: 18))
                    Text("Execute")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                }
                .foregroundColor(Color(red: 0, green: 1, blue: 0.5))
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.05, green: 0.08, blue: 0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 0, green: 1, blue: 0.5).opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color(red: 0, green: 1, blue: 0.5).opacity(glowOpacity), radius: 15)
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .onReceive(timerPublisher) { _ in
            circuitPhase += 0.02
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }

    private func triggerCircuit() {
        isPressed = true
        traceProgress = 0

        withAnimation(.easeIn(duration: 0.8)) {
            traceProgress = 1.5
        }
        withAnimation(.easeInOut(duration: 0.4)) {
            glowOpacity = 0.8
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.3)) { isPressed = false }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeOut(duration: 0.5)) {
                glowOpacity = 0.3
                traceProgress = 0
            }
        }
    }
}
