import SwiftUI

struct FullScreenButtonView: View {
    let selectedButton: ButtonDesign
    var namespace: Namespace.ID
    let onBack: () -> Void
    let onSelectButton: (ButtonDesign) -> Void
    var onBuildIt: ((ButtonDesign) -> Void)?

    @State private var contentAppeared = false
    @State private var buttonScale: CGFloat = 0.5
    @State private var buttonOpacity: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            // Top bar with back button
            HStack {
                Button(action: {
                    HapticManager.shared.impact(.light)
                    onBack()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .opacity(0.5)
                    )
                    .overlay(
                        Capsule()
                            .stroke(.white.opacity(0.15), lineWidth: 1)
                    )
                }

                Spacer()

                // Button number
                Text("\(selectedButton.id + 1) / 20")
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .opacity(contentAppeared ? 1 : 0)

            Spacer()

            // Title
            VStack(spacing: 8) {
                Text(selectedButton.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(selectedButton.subtitle)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))

                // Build This Button pill
                Button(action: {
                    HapticManager.shared.impact(.medium)
                    onBuildIt?(selectedButton)
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: 12, weight: .semibold))
                        Text("Build This Button")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [selectedButton.primaryColor.opacity(0.4), selectedButton.secondaryColor.opacity(0.4)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                LinearGradient(
                                    colors: [selectedButton.primaryColor.opacity(0.6), selectedButton.secondaryColor.opacity(0.3)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 1
                            )
                    )
                }
                .padding(.top, 6)
            }
            .opacity(contentAppeared ? 1 : 0)
            .offset(y: contentAppeared ? 0 : 20)
            .padding(.bottom, 30)

            // Main button display
            ButtonRenderer(design: selectedButton)
                .scaleEffect(buttonScale)
                .opacity(buttonOpacity)
                .id(selectedButton.id)

            Spacer()

            // Instruction
            Text("Tap the button to see its interaction")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.3))
                .opacity(contentAppeared ? 1 : 0)
                .padding(.bottom, 20)

            // Horizontal button carousel
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(ButtonDesign.allDesigns) { design in
                            Button(action: {
                                HapticManager.shared.selection()
                                onSelectButton(design)
                            }) {
                                VStack(spacing: 6) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(design.id == selectedButton.id ?
                                                  AnyShapeStyle(
                                                    LinearGradient(
                                                        colors: [design.primaryColor.opacity(0.3), design.secondaryColor.opacity(0.3)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                  ) :
                                                    AnyShapeStyle(Color.white.opacity(0.05))
                                            )
                                            .frame(width: 56, height: 56)

                                        Image(systemName: design.icon)
                                            .font(.system(size: 20))
                                            .foregroundStyle(
                                                LinearGradient(
                                                    colors: [design.primaryColor, design.secondaryColor],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                design.id == selectedButton.id ?
                                                design.primaryColor.opacity(0.5) :
                                                    Color.white.opacity(0.1),
                                                lineWidth: design.id == selectedButton.id ? 2 : 1
                                            )
                                    )

                                    Text(design.name)
                                        .font(.system(size: 9, weight: .medium, design: .rounded))
                                        .foregroundColor(design.id == selectedButton.id ? .white : .white.opacity(0.4))
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(.plain)
                            .id(design.id)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(0.3)
                )
                .opacity(contentAppeared ? 1 : 0)
                .onChange(of: selectedButton.id) { _, newId in
                    withAnimation(.spring(response: 0.4)) {
                        proxy.scrollTo(newId, anchor: .center)
                    }
                    // Reset button animation
                    buttonScale = 0.5
                    buttonOpacity = 0
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        buttonScale = 1.0
                        buttonOpacity = 1
                    }
                }
            }

            Spacer()
                .frame(height: 30)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                contentAppeared = true
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2)) {
                buttonScale = 1.0
                buttonOpacity = 1
            }
        }
    }
}
