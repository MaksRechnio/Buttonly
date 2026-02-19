import SwiftUI

// Button 16: Retro Pixel - 8-bit arcade nostalgia
struct RetroPixelButton: View {
    @State private var isPressed = false
    @State private var pressCount = 0
    @State private var scoreOpacity: Double = 0
    @State private var scoreOffset: CGFloat = 0

    var body: some View {
        ZStack {
            // Score popup
            Text("+\(pressCount > 0 ? pressCount * 100 : 100)")
                .font(.system(size: 16, weight: .heavy, design: .monospaced))
                .foregroundColor(.green)
                .offset(y: -50 + scoreOffset)
                .opacity(scoreOpacity)

            Button(action: {
                HapticManager.shared.impact(.rigid)
                pressCount += 1
                withAnimation(.spring(response: 0.1, dampingFraction: 0.3)) {
                    isPressed = true
                }
                showScore()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.15, dampingFraction: 0.4)) {
                        isPressed = false
                    }
                }
            }) {
                VStack(spacing: 4) {
                    Text("START")
                        .font(.system(size: 20, weight: .heavy, design: .monospaced))
                        .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.2))

                    Text("▶ PRESS ◀")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.2).opacity(0.6))
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 14)
                .background(
                    ZStack {
                        // Outer pixel border
                        PixelBorder()
                            .fill(Color(red: 0.2, green: 0.8, blue: 0.2).opacity(0.2))

                        PixelBorder()
                            .stroke(Color(red: 0.2, green: 0.8, blue: 0.2), lineWidth: 2)
                    }
                )
                .shadow(color: Color(red: 0.2, green: 0.8, blue: 0.2).opacity(isPressed ? 0.8 : 0.3), radius: isPressed ? 15 : 8)
                .offset(y: isPressed ? 3 : 0)
            }
        }
        .frame(height: 120)
    }

    private func showScore() {
        scoreOffset = 0
        scoreOpacity = 1
        withAnimation(.easeOut(duration: 0.6)) {
            scoreOffset = -30
            scoreOpacity = 0
        }
    }
}

struct PixelBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step: CGFloat = 4

        // Create a pixelated rectangle
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 2, height: 2))
        _ = step // suppress warning

        return path
    }
}
