import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content
    var cornerRadius: CGFloat = 24
    var opacity: Double = 0.12

    init(cornerRadius: CGFloat = 24, opacity: Double = 0.12, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.cornerRadius = cornerRadius
        self.opacity = opacity
    }

    var body: some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .opacity(0.6)

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(opacity),
                                    .white.opacity(opacity * 0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.3),
                                    .white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
    }
}

struct GlassButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .opacity(0.8)

                    Capsule()
                        .fill(.white.opacity(0.1))

                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                }
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}
