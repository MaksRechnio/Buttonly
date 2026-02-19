import SwiftUI

// Button 5: 3D Push - Duolingo-style depth press
struct ThreeDPushButton: View {
    @State private var isPressed = false

    let frontColor = Color(red: 0.3, green: 0.85, blue: 0.4)
    let sideColor = Color(red: 0.15, green: 0.55, blue: 0.2)

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.rigid)
            withAnimation(.spring(response: 0.15, dampingFraction: 0.5)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    isPressed = false
                }
            }
        }) {
            Text("PRESS ME!")
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 36)
                .padding(.vertical, 16)
                .background(
                    ZStack {
                        // Shadow/side
                        RoundedRectangle(cornerRadius: 14)
                            .fill(sideColor)
                            .offset(y: 6)

                        // Front face
                        RoundedRectangle(cornerRadius: 14)
                            .fill(frontColor)
                            .offset(y: isPressed ? 4 : 0)
                    }
                )
                .offset(y: isPressed ? 4 : 0)
        }
    }
}
