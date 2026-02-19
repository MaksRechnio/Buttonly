import SwiftUI
import Combine

struct ButtonBuildTutorialView: View {
    let design: ButtonDesign
    let onBack: () -> Void

    @State private var currentStep = 0
    @State private var appeared = false

    private var steps: [BuildStep] {
        ButtonBuildSteps.steps(for: design.id)
    }

    private var totalSteps: Int { steps.count }
    private var isLastStep: Bool { currentStep >= totalSteps - 1 }

    var body: some View {
        VStack(spacing: 0) {
            // Top bar
            topBar
                .opacity(appeared ? 1 : 0)

            // Progress bar
            progressBar
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .opacity(appeared ? 1 : 0)

            // Live Preview (compact)
            livePreviewSection

            // Step Info (takes remaining space)
            stepInfoSection
                .frame(maxHeight: .infinity)

            Spacer().frame(height: 30)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                appeared = true
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
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

            Text("Build It")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.horizontal, 20)
        .padding(.top, 60)
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.1))

                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        LinearGradient(
                            colors: [design.primaryColor, design.secondaryColor],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * CGFloat(currentStep + 1) / CGFloat(totalSteps))
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: currentStep)
            }
        }
        .frame(height: 6)
    }

    // MARK: - Live Preview

    private var livePreviewSection: some View {
        VStack(spacing: 6) {
            Text(design.name)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(appeared ? 1 : 0)

            ZStack {
                buildPreview(for: design.id, step: currentStep)
            }
            .frame(height: 110)
            .frame(maxWidth: .infinity)
            .scaleEffect(0.85)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentStep)
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
    }

    // MARK: - Step Info

    private var stepInfoSection: some View {
        VStack(spacing: 0) {
            // Divider line
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [design.primaryColor.opacity(0.3), design.secondaryColor.opacity(0.1)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    // Step counter chip
                    HStack {
                        Text(isLastStep && currentStep == totalSteps - 1 ? "You Built It!" : "Step \(currentStep + 1) of \(totalSteps)")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(design.primaryColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(design.primaryColor.opacity(0.15))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(design.primaryColor.opacity(0.3), lineWidth: 1)
                            )

                        Spacer()
                    }

                    if currentStep < totalSteps {
                        // Step title
                        Text(steps[currentStep].title)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .id("title_\(currentStep)")
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))

                        // Description
                        Text(steps[currentStep].description)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.75))
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                            .id("desc_\(currentStep)")

                        // Code snippet with copy
                        CodeBlockView(
                            code: steps[currentStep].codeSnippet,
                            accentColor1: design.primaryColor,
                            accentColor2: design.secondaryColor
                        )
                    }

                    // Navigation buttons
                    VStack(spacing: 10) {
                        if isLastStep {
                            // Copy full code button
                            Button(action: {
                                HapticManager.shared.notification(.success)
                                let fullCode = steps.map { $0.codeSnippet }.joined(separator: "\n\n")
                                UIPasteboard.general.string = fullCode
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "doc.on.doc.fill")
                                        .font(.system(size: 15))
                                    Text("Copy Full Code")
                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(
                                            LinearGradient(
                                                colors: [design.primaryColor, design.secondaryColor],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                        } else {
                            // Next Step button
                            Button(action: {
                                HapticManager.shared.impact(.medium)
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    currentStep += 1
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Text("Next Step")
                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(
                                            LinearGradient(
                                                colors: [design.primaryColor, design.secondaryColor],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }

                        // Back button (only if not first step)
                        if currentStep > 0 {
                            Button(action: {
                                HapticManager.shared.selection()
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    currentStep -= 1
                                }
                            }) {
                                Text("Previous Step")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
        }
    }

    // MARK: - Build Preview Router

    @ViewBuilder
    private func buildPreview(for designId: Int, step: Int) -> some View {
        switch designId {
        case 0:  neonGlowPreview(step: step)
        case 1:  neumorphicPreview(step: step)
        case 2:  glassmorphicPreview(step: step)
        case 3:  liquidMorphPreview(step: step)
        case 4:  threeDPushPreview(step: step)
        case 5:  gradientWavePreview(step: step)
        case 6:  magneticPullPreview(step: step)
        case 7:  elasticJellyPreview(step: step)
        case 8:  particleBurstPreview(step: step)
        case 9:  rippleEffectPreview(step: step)
        case 10: auroraPreview(step: step)
        case 11: cyberGlitchPreview(step: step)
        case 12: pulseRingPreview(step: step)
        case 13: shimmerShinePreview(step: step)
        case 14: morphIconPreview(step: step)
        case 15: retroPixelPreview(step: step)
        case 16: holographicPreview(step: step)
        case 17: typewriterPreview(step: step)
        case 18: circuitBoardPreview(step: step)
        case 19: gravityFloatPreview(step: step)
        default: Text("Unknown").foregroundColor(.white)
        }
    }

    // MARK: - 0: Neon Glow Preview

    @ViewBuilder
    private func neonGlowPreview(step: Int) -> some View {
        let neonCyan = Color(red: 0, green: 1, blue: 0.8)
        let neonPurple = Color(red: 0.5, green: 0, blue: 1)

        Text("ACTIVATE")
            .font(.system(size: 20, design: .monospaced).weight(.black))
            .tracking(step >= 0 ? 6 : 0)
            .foregroundColor(step >= 1 ? neonCyan : .white)
            .padding(.horizontal, step >= 2 ? 40 : 16)
            .padding(.vertical, step >= 2 ? 20 : 10)
            .background(
                Group {
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black.opacity(0.8))
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 3 {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(
                                LinearGradient(
                                    colors: [neonCyan, neonPurple, neonCyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 4 ? neonCyan.opacity(0.6) : .clear, radius: 15, y: 0)
            .shadow(color: step >= 4 ? neonPurple.opacity(0.4) : .clear, radius: 25, y: 0)
            .scaleEffect(step >= 5 ? 1.0 : 1.0)
    }

    // MARK: - 1: Neumorphic Preview

    @ViewBuilder
    private func neumorphicPreview(step: Int) -> some View {
        let bgColor = Color(red: 0.22, green: 0.24, blue: 0.29)

        HStack(spacing: 12) {
            if step >= 0 {
                Image(systemName: "power")
                    .font(.system(size: 20, weight: .semibold))
                Text("Power On")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
        }
        .foregroundColor(.white.opacity(0.8))
        .padding(.horizontal, step >= 1 ? 36 : 16)
        .padding(.vertical, step >= 1 ? 18 : 10)
        .background(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(bgColor)
                        .shadow(color: step >= 2 ? .black.opacity(0.5) : .clear,
                                radius: 8, x: 6, y: 6)
                        .shadow(color: step >= 2 ? .white.opacity(0.05) : .clear,
                                radius: 8, x: -6, y: -6)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 3 {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                        .transition(.opacity)
                }
            }
        )
    }

    // MARK: - 2: Glassmorphic Preview

    @ViewBuilder
    private func glassmorphicPreview(step: Int) -> some View {
        HStack(spacing: 10) {
            if step >= 0 {
                Image(systemName: "sparkle")
                    .font(.system(size: 18))
                Text("Glass Effect")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .padding(.horizontal, step >= 1 ? 32 : 16)
        .padding(.vertical, step >= 1 ? 18 : 10)
        .background(
            Group {
                if step >= 1 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)

                        if step >= 2 {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.15),
                                            Color.white.opacity(0.05),
                                            Color.white.opacity(0.1)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .transition(.opacity)
                        }
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 3 {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.4), .white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                        .transition(.opacity)
                }
            }
        )
        .shadow(color: step >= 4 ? .blue.opacity(0.2) : .clear, radius: 15, y: 8)
    }

    // MARK: - 3: Liquid Morph Preview

    @ViewBuilder
    private func liquidMorphPreview(step: Int) -> some View {
        let pink = Color(red: 1, green: 0.4, blue: 0.6)
        let orange = Color(red: 1, green: 0.6, blue: 0.2)

        Text("Morph")
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .frame(width: 160, height: 60)
            .background(
                Group {
                    if step >= 1 {
                        Ellipse()
                            .fill(
                                step >= 2 ?
                                AnyShapeStyle(
                                    LinearGradient(
                                        colors: [pink, orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                ) :
                                AnyShapeStyle(pink.opacity(0.5))
                            )
                            .scaleEffect(x: 1.4, y: 1.0)
                            .shadow(color: step >= 3 ? pink.opacity(0.5) : .clear, radius: 20)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
    }

    // MARK: - 4: 3D Push Preview

    @ViewBuilder
    private func threeDPushPreview(step: Int) -> some View {
        let frontColor = Color(red: 0.3, green: 0.85, blue: 0.4)
        let sideColor = Color(red: 0.15, green: 0.55, blue: 0.2)

        Text("PRESS ME!")
            .font(.system(size: step >= 0 ? 20 : 18, weight: .heavy, design: .rounded))
            .foregroundColor(step >= 1 ? .white : .white.opacity(0.7))
            .padding(.horizontal, 36)
            .padding(.vertical, 16)
            .background(
                Group {
                    if step >= 2 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(sideColor)
                                .offset(y: 6)

                            RoundedRectangle(cornerRadius: 14)
                                .fill(frontColor)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
            )
    }

    // MARK: - 5: Gradient Wave Preview

    @ViewBuilder
    private func gradientWavePreview(step: Int) -> some View {
        Text("Flow")
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, step >= 1 ? 48 : 20)
            .padding(.vertical, step >= 1 ? 18 : 10)
            .background(
                Group {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1, green: 0.5, blue: 0),
                                        Color(red: 1, green: 0, blue: 0.5),
                                        Color(red: 0.5, green: 0, blue: 1),
                                        Color(red: 1, green: 0.5, blue: 0)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 2 ? Color(red: 1, green: 0.3, blue: 0.3).opacity(0.5) : .clear, radius: 15, y: 5)
    }

    // MARK: - 6: Magnetic Pull Preview

    @ViewBuilder
    private func magneticPullPreview(step: Int) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "magnet.fill")
                .font(.system(size: 18))
            Text("Attract")
                .font(.system(size: 20, weight: .bold, design: .rounded))
        }
        .foregroundColor(.white)
        .padding(.horizontal, step >= 1 ? 36 : 16)
        .padding(.vertical, step >= 1 ? 18 : 10)
        .background(
            Group {
                if step >= 1 {
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
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 2 {
                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                        .transition(.opacity)
                }
            }
        )
        .shadow(color: step >= 2 ? Color.red.opacity(0.3) : .clear, radius: 15)
    }

    // MARK: - 7: Elastic Jelly Preview

    @ViewBuilder
    private func elasticJellyPreview(step: Int) -> some View {
        Text("Squish!")
            .font(.system(size: 22, weight: .heavy, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, step >= 1 ? 40 : 16)
            .padding(.vertical, step >= 1 ? 18 : 10)
            .background(
                Group {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.6, green: 0.3, blue: 1),
                                        Color(red: 0.9, green: 0.3, blue: 0.8)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 2 ? Color.purple.opacity(0.4) : .clear, radius: 15, y: 5)
    }

    // MARK: - 8: Particle Burst Preview

    @ViewBuilder
    private func particleBurstPreview(step: Int) -> some View {
        HStack(spacing: 10) {
            if step >= 0 {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .bold))
                Text("Burst!")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
        .foregroundColor(.black)
        .padding(.horizontal, step >= 1 ? 36 : 16)
        .padding(.vertical, step >= 1 ? 18 : 10)
        .background(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1, green: 0.85, blue: 0),
                                    Color(red: 1, green: 0.5, blue: 0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                        .transition(.opacity)
                }
            }
        )
        .shadow(color: step >= 4 ? Color.orange.opacity(0.5) : .clear, radius: 15)
    }

    // MARK: - 9: Ripple Effect Preview

    @ViewBuilder
    private func rippleEffectPreview(step: Int) -> some View {
        ZStack {
            if step >= 2 {
                Circle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .transition(.scale.combined(with: .opacity))
            }

            HStack(spacing: 10) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 18))
                Text("Ripple")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, step >= 1 ? 40 : 16)
            .padding(.vertical, step >= 1 ? 18 : 10)
            .background(
                Group {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.2, green: 0.6, blue: 1),
                                        Color(red: 0.1, green: 0.4, blue: 0.9)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .shadow(color: step >= 4 ? Color.blue.opacity(0.4) : .clear, radius: 12, y: 5)
    }

    // MARK: - 10: Aurora Borealis Preview

    @ViewBuilder
    private func auroraPreview(step: Int) -> some View {
        Text("Aurora")
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, 44)
            .padding(.vertical, 18)
            .background(
                ZStack {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.black.opacity(0.3))
                            .transition(.scale.combined(with: .opacity))
                    }
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0, green: 0.9, blue: 0.6).opacity(0.6),
                                        Color(red: 0.2, green: 0.4, blue: 0.9).opacity(0.6),
                                        Color(red: 0.5, green: 0.1, blue: 0.8).opacity(0.6)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .transition(.opacity)
                    }
                    if step >= 3 {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .white.opacity(0.1), .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .transition(.opacity)
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.white.opacity(0.15), lineWidth: 1)
                    }
                }
            )
            .shadow(color: step >= 4 ? Color(red: 0, green: 0.8, blue: 0.5).opacity(0.4) : .clear, radius: 20)
    }

    // MARK: - 11: Cyber Glitch Preview

    @ViewBuilder
    private func cyberGlitchPreview(step: Int) -> some View {
        ZStack {
            if step >= 0 {
                if step >= 0 {
                    Text("GLITCH")
                        .font(.system(size: 22, weight: .black, design: .monospaced))
                        .foregroundColor(.red.opacity(step >= 0 ? 0.7 : 0))
                        .offset(x: step >= 3 ? 2 : 0, y: step >= 3 ? -1 : 0)
                }
                Text("GLITCH")
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(.cyan.opacity(step >= 0 ? 0.7 : 0))
                    .offset(x: step >= 3 ? -2 : 0, y: step >= 3 ? 1 : 0)
                Text("GLITCH")
                    .font(.system(size: 22, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 36)
        .padding(.vertical, 18)
        .background(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.red.opacity(0.15),
                                            Color.clear,
                                            Color.cyan.opacity(0.15)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 2 {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(
                            LinearGradient(
                                colors: [Color.red.opacity(0.5), Color.cyan.opacity(0.5)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 1
                        )
                        .transition(.opacity)
                }
            }
        )
    }

    // MARK: - 12: Pulse Ring Preview

    @ViewBuilder
    private func pulseRingPreview(step: Int) -> some View {
        let blue = Color(red: 0.3, green: 0.8, blue: 1)

        ZStack {
            if step >= 1 {
                Circle()
                    .stroke(blue.opacity(0.3), lineWidth: 1.5)
                    .frame(width: 110, height: 110)
                    .transition(.scale.combined(with: .opacity))
            }

            if step >= 0 {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [blue, Color(red: 0.1, green: 0.4, blue: 0.9)],
                                center: .center,
                                startRadius: 0,
                                endRadius: 40
                            )
                        )
                        .frame(width: 80, height: 80)

                    Image(systemName: "dot.radiowaves.right")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                .shadow(color: step >= 4 ? blue.opacity(0.5) : .clear, radius: 20)
            }
        }
    }

    // MARK: - 13: Shimmer Shine Preview

    @ViewBuilder
    private func shimmerShinePreview(step: Int) -> some View {
        let gold = Color(red: 0.85, green: 0.75, blue: 0.55)

        Text("Premium")
            .font(.system(size: 20, weight: .bold, design: .serif))
            .foregroundStyle(
                step >= 0 ?
                AnyShapeStyle(
                    LinearGradient(
                        colors: [gold, Color(red: 0.95, green: 0.9, blue: 0.7), gold],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                ) :
                AnyShapeStyle(.white)
            )
            .padding(.horizontal, step >= 1 ? 40 : 16)
            .padding(.vertical, step >= 1 ? 18 : 10)
            .background(
                Group {
                    if step >= 1 {
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
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 3 {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(
                                LinearGradient(
                                    colors: [gold.opacity(0.5), gold.opacity(0.1), gold.opacity(0.3)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 4 ? gold.opacity(0.3) : .clear, radius: 12, y: 5)
    }

    // MARK: - 14: Morph Icon Preview

    @ViewBuilder
    private func morphIconPreview(step: Int) -> some View {
        let iconColor = Color(red: 0.9, green: 0.3, blue: 0.5)
        let nextColor = Color(red: 1, green: 0.3, blue: 0.3)

        HStack(spacing: 14) {
            if step >= 0 {
                Image(systemName: "star.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Text("Transform")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, step >= 2 ? 32 : 16)
        .padding(.vertical, step >= 2 ? 18 : 10)
        .background(
            Group {
                if step >= 2 {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [iconColor, nextColor],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 4 {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                        .transition(.opacity)
                }
            }
        )
        .shadow(color: step >= 4 ? iconColor.opacity(0.5) : .clear, radius: 15, y: 5)
    }

    // MARK: - 15: Retro Pixel Preview

    @ViewBuilder
    private func retroPixelPreview(step: Int) -> some View {
        let green = Color(red: 0.2, green: 0.8, blue: 0.2)

        VStack(spacing: 4) {
            Text("START")
                .font(.system(size: 20, weight: .heavy, design: .monospaced))
                .foregroundColor(green)

            Text("\u{25B6} PRESS \u{25C0}")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(green.opacity(0.6))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
        .background(
            Group {
                if step >= 1 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(green.opacity(0.2))
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(step >= 2 ? green : green.opacity(0.3), lineWidth: 2)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .shadow(color: step >= 2 ? green.opacity(0.3) : .clear, radius: 8)
    }

    // MARK: - 16: Holographic Preview

    @ViewBuilder
    private func holographicPreview(step: Int) -> some View {
        Text("Holo")
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, 44)
            .padding(.vertical, 18)
            .background(
                ZStack {
                    if step >= 1 {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(red: 0.15, green: 0.1, blue: 0.2))
                            .transition(.scale.combined(with: .opacity))
                    }
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                AngularGradient(
                                    colors: [
                                        Color.red.opacity(0.4),
                                        Color.orange.opacity(0.4),
                                        Color.yellow.opacity(0.4),
                                        Color.green.opacity(0.4),
                                        Color.cyan.opacity(0.4),
                                        Color.blue.opacity(0.4),
                                        Color.purple.opacity(0.4),
                                        Color.red.opacity(0.4)
                                    ],
                                    center: .center
                                )
                            )
                            .transition(.opacity)
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 2 {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                AngularGradient(
                                    colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .red],
                                    center: .center
                                ),
                                lineWidth: 1.5
                            )
                            .opacity(0.6)
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 4 ? Color.purple.opacity(0.3) : .clear, radius: 15)
    }

    // MARK: - 17: Typewriter Preview

    @ViewBuilder
    private func typewriterPreview(step: Int) -> some View {
        let cream = Color(red: 0.95, green: 0.9, blue: 0.8)

        HStack(spacing: 0) {
            Text("CLICK ME")
                .font(.system(size: 18, weight: .medium, design: .monospaced))
                .foregroundColor(cream)

            if step >= 0 {
                Rectangle()
                    .fill(cream)
                    .frame(width: 2, height: 22)
            }
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .background(
            Group {
                if step >= 1 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.3, green: 0.28, blue: 0.24),
                                        Color(red: 0.22, green: 0.2, blue: 0.17)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        if step >= 1 {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.4, green: 0.35, blue: 0.28), lineWidth: 2)
                        }
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .shadow(color: step >= 2 ? .black.opacity(0.4) : .clear, radius: 5, y: 4)
    }

    // MARK: - 18: Circuit Board Preview

    @ViewBuilder
    private func circuitBoardPreview(step: Int) -> some View {
        let circuitGreen = Color(red: 0, green: 1, blue: 0.5)

        HStack(spacing: 10) {
            Image(systemName: "cpu.fill")
                .font(.system(size: 18))
            Text("Execute")
                .font(.system(size: 18, weight: .bold, design: .monospaced))
        }
        .foregroundColor(circuitGreen)
        .padding(.horizontal, 30)
        .padding(.vertical, 18)
        .background(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.05, green: 0.08, blue: 0.05))
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .overlay(
            Group {
                if step >= 1 {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(circuitGreen.opacity(0.3), lineWidth: 1)
                        .transition(.opacity)
                }
            }
        )
        .shadow(color: step >= 4 ? circuitGreen.opacity(0.5) : .clear, radius: 15)
    }

    // MARK: - 19: Gravity Float Preview

    @ViewBuilder
    private func gravityFloatPreview(step: Int) -> some View {
        ZStack {
            if step >= 2 {
                ForEach(0..<4, id: \.self) { i in
                    Circle()
                        .fill(Color(red: 0.5, green: 0.7, blue: 1).opacity(0.4))
                        .frame(width: 4, height: 4)
                        .offset(
                            x: cos(Double(i) * .pi / 2) * 70,
                            y: sin(Double(i) * .pi / 2) * 25
                        )
                }
                .transition(.scale.combined(with: .opacity))
            }

            HStack(spacing: 10) {
                Image(systemName: "arrow.up.and.down.circle.fill")
                    .font(.system(size: 20))
                Text("Float")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.horizontal, step >= 1 ? 36 : 16)
            .padding(.vertical, step >= 1 ? 18 : 10)
            .background(
                Group {
                    if step >= 1 {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.5, green: 0.7, blue: 1),
                                        Color(red: 0.3, green: 0.4, blue: 0.9)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            .overlay(
                Group {
                    if step >= 1 {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                            .transition(.opacity)
                    }
                }
            )
            .shadow(color: step >= 3 ? Color(red: 0.4, green: 0.5, blue: 1).opacity(0.4) : .clear,
                    radius: 10, y: 5)
        }
    }
}
