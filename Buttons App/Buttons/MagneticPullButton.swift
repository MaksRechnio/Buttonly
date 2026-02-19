import SwiftUI

// Button 7: Magnetic Pull - Draggable with snap-back
struct MagneticPullButton: View {
    @State private var offset: CGSize = .zero
    @State private var isPressed = false
    @State private var glowIntensity: CGFloat = 0

    var body: some View {
        Button(action: {
            HapticManager.shared.notification(.success)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                isPressed = true
                glowIntensity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    isPressed = false
                    glowIntensity = 0
                }
            }
        }) {
            HStack(spacing: 10) {
                Image(systemName: "magnet.fill")
                    .font(.system(size: 18))
                    .rotationEffect(.degrees(isPressed ? 15 : 0))
                Text("Attract")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 36)
            .padding(.vertical, 18)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.9, green: 0.2, blue: 0.3),
                                Color(red: 1, green: 0.4, blue: 0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                Capsule()
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.red.opacity(0.3 + glowIntensity * 0.4), radius: 15 + glowIntensity * 15)
            .scaleEffect(isPressed ? 1.08 : 1.0)
        }
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let maxDistance: CGFloat = 30
                    let translation = value.translation
                    let distance = sqrt(pow(translation.width, 2) + pow(translation.height, 2))
                    let factor = min(distance, maxDistance) / max(distance, 1)
                    offset = CGSize(width: translation.width * factor, height: translation.height * factor)
                    HapticManager.shared.selection()
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.3)) {
                        offset = .zero
                    }
                    HapticManager.shared.impact(.light)
                }
        )
    }
}
