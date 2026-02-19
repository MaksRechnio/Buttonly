import SwiftUI

// Button 8: Elastic Jelly - Bouncy squish effect
struct ElasticJellyButton: View {
    @State private var isPressed = false
    @State private var scaleX: CGFloat = 1
    @State private var scaleY: CGFloat = 1
    @State private var wobble: CGFloat = 0

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.soft)
            triggerJelly()
        }) {
            Text("Squish!")
                .font(.system(size: 22, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.6, green: 0.3, blue: 1),
                                    Color(red: 0.9, green: 0.3, blue: 0.8)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color.purple.opacity(0.4), radius: 15, y: 5)
        }
        .scaleEffect(x: scaleX, y: scaleY)
        .rotationEffect(.degrees(wobble))
    }

    private func triggerJelly() {
        // Squish down
        withAnimation(.spring(response: 0.15, dampingFraction: 0.3)) {
            scaleX = 1.2
            scaleY = 0.8
            wobble = -3
        }

        // Bounce back overshoot
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.3)) {
                scaleX = 0.85
                scaleY = 1.15
                wobble = 3
            }
        }

        // Second wobble
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.3)) {
                scaleX = 1.08
                scaleY = 0.92
                wobble = -1.5
            }
        }

        // Settle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                scaleX = 1
                scaleY = 1
                wobble = 0
            }
        }
    }
}
