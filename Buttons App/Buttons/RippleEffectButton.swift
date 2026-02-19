import SwiftUI

// Button 10: Ripple Effect - Material Design water ripple
struct RippleEffectButton: View {
    @State private var isPressed = false
    @State private var rippleScale: CGFloat = 0
    @State private var rippleOpacity: Double = 0.4
    @State private var showRipple = false

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.light)
            triggerRipple()
        }) {
            ZStack {
                // Ripple circle
                if showRipple {
                    Circle()
                        .fill(.white.opacity(rippleOpacity))
                        .scaleEffect(rippleScale)
                        .frame(width: 200, height: 200)
                }

                HStack(spacing: 10) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 18))
                    Text("Ripple")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 18)
            }
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.6, blue: 1),
                                Color(red: 0.1, green: 0.4, blue: 0.9)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: Color.blue.opacity(0.4), radius: 12, y: 5)
            .scaleEffect(isPressed ? 0.96 : 1.0)
        }
    }

    private func triggerRipple() {
        showRipple = true
        rippleScale = 0
        rippleOpacity = 0.4

        withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
            isPressed = true
        }

        withAnimation(.easeOut(duration: 0.6)) {
            rippleScale = 2
            rippleOpacity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(response: 0.3)) { isPressed = false }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            showRipple = false
        }
    }
}
