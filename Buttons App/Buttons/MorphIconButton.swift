import SwiftUI

// Button 15: Morph Icon - Shape-shifting icon animation
struct MorphIconButton: View {
    @State private var isPressed = false
    @State private var currentIcon = 0
    @State private var iconRotation: Double = 0
    @State private var iconScale: CGFloat = 1

    let icons = ["star.fill", "heart.fill", "bolt.fill", "flame.fill", "moon.fill"]
    let colors: [Color] = [
        Color(red: 0.9, green: 0.3, blue: 0.5),
        Color(red: 1, green: 0.3, blue: 0.3),
        Color(red: 1, green: 0.7, blue: 0),
        Color(red: 1, green: 0.4, blue: 0.1),
        Color(red: 0.5, green: 0.3, blue: 0.9)
    ]

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            morphToNext()
        }) {
            HStack(spacing: 14) {
                Image(systemName: icons[currentIcon])
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(iconRotation))
                    .scaleEffect(iconScale)

                Text("Transform")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [colors[currentIcon], colors[(currentIcon + 1) % colors.count]],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: colors[currentIcon].opacity(0.5), radius: 15, y: 5)
            .scaleEffect(isPressed ? 0.92 : 1.0)
        }
    }

    private func morphToNext() {
        // Spin out
        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
            iconScale = 0
            iconRotation += 180
            isPressed = true
        }

        // Switch icon and spin in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            currentIcon = (currentIcon + 1) % icons.count
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                iconScale = 1
                iconRotation += 180
                isPressed = false
            }
        }
    }
}
