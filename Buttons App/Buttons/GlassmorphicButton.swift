import SwiftUI

// Button 3: Glassmorphic - Frosted glass transparency
struct GlassmorphicButton: View {
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -200

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.light)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            withAnimation(.easeInOut(duration: 0.6)) {
                shimmerOffset = 200
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4)) { isPressed = false }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                shimmerOffset = -200
            }
        }) {
            HStack(spacing: 10) {
                Image(systemName: "sparkle")
                    .font(.system(size: 18))
                    .symbolEffect(.pulse, isActive: true)
                Text("Glass Effect")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
            }
            .foregroundColor(.white.opacity(0.9))
            .padding(.horizontal, 32)
            .padding(.vertical, 18)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.15),
                                    Color.white.opacity(0.05),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    // Shimmer
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.clear, .white.opacity(0.2), .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .offset(x: shimmerOffset)
                        .mask(RoundedRectangle(cornerRadius: 20))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.4), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .blue.opacity(0.2), radius: 15, y: 8)
            .scaleEffect(isPressed ? 0.94 : 1.0)
        }
    }
}
