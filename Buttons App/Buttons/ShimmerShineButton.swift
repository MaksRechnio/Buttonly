import SwiftUI

// Button 14: Shimmer Shine - Metallic light sweep
struct ShimmerShineButton: View {
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -1

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.light)
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                isPressed = true
            }
            // Trigger shimmer
            shimmerOffset = -1
            withAnimation(.easeInOut(duration: 0.8)) {
                shimmerOffset = 2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3)) { isPressed = false }
            }
        }) {
            Text("Premium")
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.85, green: 0.75, blue: 0.55),
                            Color(red: 0.95, green: 0.9, blue: 0.7),
                            Color(red: 0.85, green: 0.75, blue: 0.55)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.horizontal, 40)
                .padding(.vertical, 18)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.15, green: 0.12, blue: 0.08),
                                        Color(red: 0.25, green: 0.2, blue: 0.12),
                                        Color(red: 0.15, green: 0.12, blue: 0.08)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        // Shimmer sweep
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .white.opacity(0.15),
                                        .white.opacity(0.25),
                                        .white.opacity(0.15),
                                        .clear
                                    ],
                                    startPoint: UnitPoint(x: shimmerOffset - 0.3, y: 0),
                                    endPoint: UnitPoint(x: shimmerOffset, y: 1)
                                )
                            )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.5),
                                    Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.1),
                                    Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
                .shadow(color: Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.3), radius: 12, y: 5)
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .onAppear {
            // Idle shimmer loop
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false).delay(1)) {
                shimmerOffset = 2
            }
        }
    }
}
