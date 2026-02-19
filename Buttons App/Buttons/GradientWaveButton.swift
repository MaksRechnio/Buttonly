import SwiftUI

// Button 6: Gradient Wave - Animated flowing gradient
struct GradientWaveButton: View {
    @State private var isPressed = false
    @State private var gradientOffset: CGFloat = 0

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4)) { isPressed = false }
            }
        }) {
            Text("Flow")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 48)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1, green: 0.5, blue: 0),
                                    Color(red: 1, green: 0, blue: 0.5),
                                    Color(red: 0.5, green: 0, blue: 1),
                                    Color(red: 1, green: 0.5, blue: 0)
                                ],
                                startPoint: UnitPoint(x: gradientOffset, y: 0),
                                endPoint: UnitPoint(x: gradientOffset + 1, y: 1)
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color(red: 1, green: 0.3, blue: 0.3).opacity(0.5), radius: 15, y: 5)
                .scaleEffect(isPressed ? 0.92 : 1.0)
                .rotation3DEffect(.degrees(isPressed ? 5 : 0), axis: (x: 1, y: 0, z: 0))
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                gradientOffset = 1
            }
        }
    }
}
