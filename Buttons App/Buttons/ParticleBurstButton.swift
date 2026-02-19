import SwiftUI

// Button 9: Particle Burst - Explosive particle shower on click
struct ParticleBurstButton: View {
    @State private var isPressed = false
    @State private var particles: [Particle] = []
    @State private var showParticles = false

    struct Particle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var targetX: CGFloat
        var targetY: CGFloat
        var scale: CGFloat
        var opacity: Double
        var color: Color
    }

    var body: some View {
        ZStack {
            // Particles
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: 6 * particle.scale, height: 6 * particle.scale)
                    .offset(x: showParticles ? particle.targetX : particle.x,
                            y: showParticles ? particle.targetY : particle.y)
                    .opacity(showParticles ? 0 : particle.opacity)
            }

            Button(action: {
                HapticManager.shared.complexPattern()
                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                    isPressed = true
                }
                emitParticles()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring(response: 0.3)) { isPressed = false }
                }
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 18, weight: .bold))
                    Text("Burst!")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                .foregroundColor(.black)
                .padding(.horizontal, 36)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1, green: 0.85, blue: 0),
                                    Color(red: 1, green: 0.5, blue: 0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.orange.opacity(0.5), radius: isPressed ? 25 : 15)
                .scaleEffect(isPressed ? 0.9 : 1.0)
            }
        }
        .frame(width: 300, height: 200)
    }

    private func emitParticles() {
        let colors: [Color] = [.yellow, .orange, .red, Color(red: 1, green: 0.8, blue: 0)]
        particles = (0..<20).map { _ in
            let angle = CGFloat.random(in: 0...(2 * .pi))
            let distance = CGFloat.random(in: 50...120)
            return Particle(
                x: 0, y: 0,
                targetX: cos(angle) * distance,
                targetY: sin(angle) * distance,
                scale: CGFloat.random(in: 0.5...2),
                opacity: Double.random(in: 0.6...1),
                color: colors.randomElement() ?? .yellow
            )
        }
        showParticles = false
        withAnimation(.easeOut(duration: 0.6)) {
            showParticles = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            particles = []
            showParticles = false
        }
    }
}
