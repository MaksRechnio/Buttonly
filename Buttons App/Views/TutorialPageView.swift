import SwiftUI

struct TutorialPageView: View {
    let page: TutorialPage
    let accentColor1: Color
    let accentColor2: Color

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                ForEach(page.blocks) { block in
                    blockView(for: block)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 60)
        }
    }

    @ViewBuilder
    private func blockView(for block: ContentBlock) -> some View {
        switch block {
        case .heading(let text):
            headingView(text)
        case .text(let text):
            textView(text)
        case .code(let code):
            codeView(code)
        case .tip(let tip):
            tipView(tip)
        case .liveDemo(let demoType):
            liveDemoView(demoType)
        case .definition(let term, let explanation):
            DefinitionBlockView(
                term: term,
                explanation: explanation,
                accentColor: accentColor1
            )
        case .visualExample(let icon, let caption):
            visualExampleView(icon: icon, caption: caption)
        }
    }

    // MARK: - Heading

    private func headingView(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(text)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            LinearGradient(
                colors: [accentColor1, accentColor2.opacity(0.3)],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 3)
            .cornerRadius(2)
        }
    }

    // MARK: - Text

    private func textView(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 18, weight: .regular, design: .rounded))
            .foregroundColor(.white.opacity(0.85))
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - Code Block

    private func codeView(_ code: String) -> some View {
        CodeBlockView(code: code, accentColor1: accentColor1, accentColor2: accentColor2)
    }

    // MARK: - Tip

    private func tipView(_ tip: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 2)
                .fill(
                    LinearGradient(
                        colors: [accentColor1, accentColor2],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 4)

            VStack(alignment: .leading, spacing: 4) {
                Text("Try This")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(accentColor1)

                Text(tip)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(14)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(accentColor1.opacity(0.08))

                RoundedRectangle(cornerRadius: 12)
                    .stroke(accentColor1.opacity(0.15), lineWidth: 1)
            }
        )
    }

    // MARK: - Live Demo

    private func liveDemoView(_ type: LiveDemoType) -> some View {
        VStack(spacing: 12) {
            Text("INTERACTIVE DEMO")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(accentColor1.opacity(0.7))
                .tracking(2)

            demoButton(for: type)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
        }
        .padding(20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .opacity(0.4)

                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [accentColor1.opacity(0.3), accentColor2.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
        )
    }

    @ViewBuilder
    private func demoButton(for type: LiveDemoType) -> some View {
        switch type {
        case .threeDPush:
            ThreeDPushButton()
        case .neumorphic:
            NeumorphicButton()
        case .neonGlow:
            NeonGlowButton()
        case .gradientWave:
            GradientWaveButton()
        case .glassmorphic:
            GlassmorphicButton()
        }
    }

    // MARK: - Visual Example

    private func visualExampleView(icon: String, caption: String) -> some View {
        VStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(
                    LinearGradient(
                        colors: [accentColor1, accentColor2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Text(caption)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .opacity(0.3)

                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [accentColor1.opacity(0.25), accentColor2.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
        )
    }
}

// MARK: - Code Block (stateful for copy feedback)

struct CodeBlockView: View {
    let code: String
    let accentColor1: Color
    let accentColor2: Color

    @State private var copied = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundColor(.white.opacity(0.9))
                    .lineSpacing(3)
            }
            .padding(16)
            .padding(.trailing, 32)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.black.opacity(0.5))

                    RoundedRectangle(cornerRadius: 14)
                        .fill(.ultraThinMaterial)
                        .opacity(0.3)

                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            LinearGradient(
                                colors: [accentColor1.opacity(0.4), accentColor2.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )

            Button(action: {
                UIPasteboard.general.string = code
                HapticManager.shared.notification(.success)
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    copied = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        copied = false
                    }
                }
            }) {
                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(copied ? .green : .white.opacity(0.5))
                    .frame(width: 32, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.ultraThinMaterial)
                            .opacity(0.5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
            }
            .padding(8)
        }
    }
}

// MARK: - Definition Block (stateful, needs its own view)

private struct DefinitionBlockView: View {
    let term: String
    let explanation: String
    let accentColor: Color

    @State private var isExpanded = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                isExpanded.toggle()
            }
        }) {
            VStack(alignment: .leading, spacing: isExpanded ? 10 : 0) {
                HStack(spacing: 8) {
                    Image(systemName: isExpanded ? "questionmark.circle.fill" : "questionmark.circle")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(accentColor)

                    Text(term)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(accentColor)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(accentColor.opacity(0.6))
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }

                if isExpanded {
                    Text(explanation)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding(14)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(accentColor.opacity(isExpanded ? 0.1 : 0.05))

                    RoundedRectangle(cornerRadius: 12)
                        .stroke(accentColor.opacity(isExpanded ? 0.3 : 0.15), lineWidth: 1)
                }
            )
        }
        .buttonStyle(.plain)
    }
}
