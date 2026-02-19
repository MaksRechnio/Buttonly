import SwiftUI

struct ButtonRenderer: View {
    let design: ButtonDesign

    var body: some View {
        Group {
            switch design.id {
            case 0:  NeonGlowButton()
            case 1:  NeumorphicButton()
            case 2:  GlassmorphicButton()
            case 3:  LiquidMorphButton()
            case 4:  ThreeDPushButton()
            case 5:  GradientWaveButton()
            case 6:  MagneticPullButton()
            case 7:  ElasticJellyButton()
            case 8:  ParticleBurstButton()
            case 9:  RippleEffectButton()
            case 10: AuroraBorealisButton()
            case 11: CyberGlitchButton()
            case 12: PulseRingButton()
            case 13: ShimmerShineButton()
            case 14: MorphIconButton()
            case 15: RetroPixelButton()
            case 16: HolographicButton()
            case 17: TypewriterButton()
            case 18: CircuitBoardButton()
            case 19: GravityFloatButton()
            default: Text("Unknown")
            }
        }
    }
}

// Mini preview card for the grid
struct ButtonPreviewCard: View {
    let design: ButtonDesign
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.3))
                    .frame(height: 100)

                Image(systemName: design.icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [design.primaryColor, design.secondaryColor],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: design.primaryColor.opacity(0.5), radius: 10)
            }

            VStack(spacing: 4) {
                Text(design.name)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(design.subtitle)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
                    .lineLimit(1)
            }
        }
        .padding(12)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .opacity(0.5)

                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.08),
                                .white.opacity(0.02)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.2),
                                .white.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
        )
        .scaleEffect(appeared ? 1 : 0.8)
        .opacity(appeared ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(Double(design.id) * 0.05)) {
                appeared = true
            }
        }
    }
}
