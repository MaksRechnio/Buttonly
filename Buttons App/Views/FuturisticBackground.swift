import SwiftUI
import Combine

struct FuturisticBackground: View {
    @State private var phase: CGFloat = 0
    @State private var orbPositions: [CGPoint] = []
    @State private var orbSizes: [CGFloat] = []
    @State private var orbColors: [Color] = []
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Deep dark base
                Color.black

                // Animated mesh gradient orbs
                ForEach(0..<6, id: \.self) { i in
                    if i < orbPositions.count {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [orbColors[safe: i] ?? .blue, .clear],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: orbSizes[safe: i] ?? 200
                                )
                            )
                            .frame(width: (orbSizes[safe: i] ?? 200) * 2,
                                   height: (orbSizes[safe: i] ?? 200) * 2)
                            .position(orbPositions[safe: i] ?? .zero)
                            .blur(radius: 60)
                            .opacity(0.4)
                    }
                }

                // Grid overlay
                GridOverlay(phase: phase)
                    .opacity(0.08)

                // Floating particles
                ForEach(0..<30, id: \.self) { i in
                    FloatingParticle(index: i, phase: phase, bounds: geo.size)
                }

                // Top vignette
                LinearGradient(
                    colors: [.black.opacity(0.7), .clear, .clear, .black.opacity(0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .onAppear {
                initOrbs(size: geo.size)
                timerCancellable = timerPublisher.connect()
            }
            .onDisappear {
                timerCancellable?.cancel()
            }
            .onReceive(timerPublisher) { _ in
                phase += 0.01
                animateOrbs(size: geo.size)
            }
        }
    }

    private func initOrbs(size: CGSize) {
        let colors: [Color] = [
            Color(red: 0.2, green: 0, blue: 0.8),
            Color(red: 0, green: 0.5, blue: 0.8),
            Color(red: 0.5, green: 0, blue: 0.6),
            Color(red: 0, green: 0.3, blue: 0.7),
            Color(red: 0.3, green: 0, blue: 0.9),
            Color(red: 0, green: 0.6, blue: 0.5)
        ]
        orbPositions = (0..<6).map { _ in
            CGPoint(x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: 0...size.height))
        }
        orbSizes = (0..<6).map { _ in CGFloat.random(in: 120...280) }
        orbColors = colors
    }

    private func animateOrbs(size: CGSize) {
        for i in 0..<orbPositions.count {
            let speed: CGFloat = 0.3 + CGFloat(i) * 0.1
            orbPositions[i].x += sin(phase * speed + CGFloat(i) * 1.3) * 0.8
            orbPositions[i].y += cos(phase * speed * 0.7 + CGFloat(i) * 0.9) * 0.6

            if orbPositions[i].x < -100 { orbPositions[i].x = size.width + 100 }
            if orbPositions[i].x > size.width + 100 { orbPositions[i].x = -100 }
            if orbPositions[i].y < -100 { orbPositions[i].y = size.height + 100 }
            if orbPositions[i].y > size.height + 100 { orbPositions[i].y = -100 }
        }
    }
}

struct GridOverlay: View {
    let phase: CGFloat
    let spacing: CGFloat = 40

    var body: some View {
        Canvas { context, size in
            let columns = Int(size.width / spacing) + 2
            let rows = Int(size.height / spacing) + 2
            let offset = phase.truncatingRemainder(dividingBy: 1.0) * spacing

            // Vertical lines
            for col in 0..<columns {
                let x = CGFloat(col) * spacing + offset
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                context.stroke(path, with: .color(.cyan.opacity(0.3)), lineWidth: 0.5)
            }

            // Horizontal lines with perspective
            for row in 0..<rows {
                let y = CGFloat(row) * spacing
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                let opacity = 0.1 + (y / size.height) * 0.3
                context.stroke(path, with: .color(.cyan.opacity(opacity)), lineWidth: 0.5)
            }
        }
    }
}

struct FloatingParticle: View {
    let index: Int
    let phase: CGFloat
    let bounds: CGSize

    @State private var startX: CGFloat = 0
    @State private var startY: CGFloat = 0
    @State private var particleSize: CGFloat = 2

    var body: some View {
        let speed = 0.2 + Double(index % 5) * 0.15
        let x = startX + sin(phase * speed + Double(index) * 0.7) * 30
        let y = startY + cos(phase * speed * 0.6 + Double(index) * 1.1) * 20

        Circle()
            .fill(.white)
            .frame(width: particleSize, height: particleSize)
            .position(x: x, y: y)
            .opacity(0.2 + sin(phase * 2 + Double(index)) * 0.15)
            .onAppear {
                startX = CGFloat.random(in: 0...bounds.width)
                startY = CGFloat.random(in: 0...bounds.height)
                particleSize = CGFloat.random(in: 1...3)
            }
    }
}

// Safe array subscript
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    FuturisticBackground()
}
