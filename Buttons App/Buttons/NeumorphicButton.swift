import SwiftUI

// Button 2: Neumorphic - Soft UI with raised/pressed effect
struct NeumorphicButton: View {
    @State private var isPressed = false

    let bgColor = Color(red: 0.22, green: 0.24, blue: 0.29)

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.soft)
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: "power")
                    .font(.system(size: 20, weight: .semibold))
                Text("Power On")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white.opacity(isPressed ? 0.5 : 0.8))
            .padding(.horizontal, 36)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(bgColor)
                    .shadow(color: .black.opacity(isPressed ? 0 : 0.5),
                            radius: isPressed ? 2 : 8,
                            x: isPressed ? 0 : 6,
                            y: isPressed ? 0 : 6)
                    .shadow(color: .white.opacity(isPressed ? 0 : 0.05),
                            radius: isPressed ? 2 : 8,
                            x: isPressed ? 0 : -6,
                            y: isPressed ? 0 : -6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isPressed ? Color.black.opacity(0.1) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
        }
    }
}
