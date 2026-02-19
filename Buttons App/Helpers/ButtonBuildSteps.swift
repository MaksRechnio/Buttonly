import Foundation

struct BuildStep: Identifiable {
    let id: Int
    let title: String
    let description: String
    let codeSnippet: String
}

struct ButtonBuildSteps {
    static func steps(for designId: Int) -> [BuildStep] {
        switch designId {
        case 0: return neonGlowSteps
        case 1: return neumorphicSteps
        case 2: return glassmorphicSteps
        case 3: return liquidMorphSteps
        case 4: return threeDPushSteps
        case 5: return gradientWaveSteps
        case 6: return magneticPullSteps
        case 7: return elasticJellySteps
        case 8: return particleBurstSteps
        case 9: return rippleEffectSteps
        case 10: return auroraSteps
        case 11: return cyberGlitchSteps
        case 12: return pulseRingSteps
        case 13: return shimmerShineSteps
        case 14: return morphIconSteps
        case 15: return retroPixelSteps
        case 16: return holographicSteps
        case 17: return typewriterSteps
        case 18: return circuitBoardSteps
        case 19: return gravityFloatSteps
        default: return []
        }
    }

    // MARK: - 0: Neon Glow

    static let neonGlowSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Create the Label",
                  description: "Start with a bold \"ACTIVATE\" text using monospaced font and wide letter tracking for that cyberpunk terminal look.",
                  codeSnippet: """
Text("ACTIVATE")
    .font(.system(size: 20, design: .monospaced)
        .weight(.black))
    .tracking(6)
"""),
        BuildStep(id: 1, title: "Add Neon Colors",
                  description: "Define your neon cyan and purple colors, then apply the cyan as the text color.",
                  codeSnippet: """
let neonCyan = Color(red: 0, green: 1, blue: 0.8)
let neonPurple = Color(red: 0.5, green: 0, blue: 1)

.foregroundColor(neonCyan)
"""),
        BuildStep(id: 2, title: "Dark Background",
                  description: "Add padding and a near-black rounded rectangle background to make the neon colors pop.",
                  codeSnippet: """
.padding(.horizontal, 40)
.padding(.vertical, 20)
.background(
    RoundedRectangle(cornerRadius: 4)
        .fill(Color.black.opacity(0.8))
)
"""),
        BuildStep(id: 3, title: "Gradient Border",
                  description: "Overlay a gradient stroke that cycles through cyan and purple for the electric border effect.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 4)
        .stroke(
            LinearGradient(
                colors: [neonCyan, neonPurple, neonCyan],
                startPoint: .leading,
                endPoint: .trailing
            ),
            lineWidth: 2
        )
)
"""),
        BuildStep(id: 4, title: "Double Neon Glow",
                  description: "Stack two shadow layers — cyan close and purple wide — for that authentic neon tube glow.",
                  codeSnippet: """
.shadow(color: neonCyan.opacity(0.6),
        radius: 15 + borderGlow * 20, y: 0)
.shadow(color: neonPurple.opacity(0.4),
        radius: 25 + borderGlow * 15, y: 0)
"""),
        BuildStep(id: 5, title: "Animate & Interact",
                  description: "Add a pulsating glow animation that repeats forever, and a press scale effect with haptic feedback.",
                  codeSnippet: """
.scaleEffect(isPressed ? 0.92 : 1.0)

// On appear:
withAnimation(.easeInOut(duration: 1.5)
    .repeatForever(autoreverses: true)) {
    borderGlow = 1
}
"""),
    ]

    // MARK: - 1: Neumorphic

    static let neumorphicSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Icon + Label",
                  description: "Create an HStack with a power icon and \"Power On\" text in a rounded, semibold font.",
                  codeSnippet: """
HStack(spacing: 12) {
    Image(systemName: "power")
        .font(.system(size: 20, weight: .semibold))
    Text("Power On")
        .font(.system(size: 18, weight: .semibold,
              design: .rounded))
}
.foregroundColor(.white.opacity(0.8))
"""),
        BuildStep(id: 1, title: "Soft Background",
                  description: "Add padding and a dark gray rounded rectangle that matches the surface color for the soft UI look.",
                  codeSnippet: """
let bgColor = Color(red: 0.22, green: 0.24, blue: 0.29)

.padding(.horizontal, 36)
.padding(.vertical, 18)
.background(
    RoundedRectangle(cornerRadius: 16)
        .fill(bgColor)
)
"""),
        BuildStep(id: 2, title: "Dual Shadows",
                  description: "The neumorphic magic: a dark shadow bottom-right and a subtle light shadow top-left create the raised 3D illusion.",
                  codeSnippet: """
.shadow(color: .black.opacity(0.5),
        radius: 8, x: 6, y: 6)
.shadow(color: .white.opacity(0.05),
        radius: 8, x: -6, y: -6)
"""),
        BuildStep(id: 3, title: "Subtle Border",
                  description: "Add a very faint white stroke overlay for the finishing edge definition.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 16)
        .stroke(Color.white.opacity(0.05),
                lineWidth: 1)
)
"""),
        BuildStep(id: 4, title: "Press Animation",
                  description: "On press, flatten the shadows (making it look pushed in), dim the text, and scale down slightly with spring animation.",
                  codeSnippet: """
// Shadows change on press:
.shadow(radius: isPressed ? 2 : 8,
        x: isPressed ? 0 : 6,
        y: isPressed ? 0 : 6)
.scaleEffect(isPressed ? 0.97 : 1.0)

// + inner fill on press:
.overlay(
    RoundedRectangle(cornerRadius: 16)
        .fill(isPressed ? Color.black.opacity(0.1)
              : Color.clear)
)
"""),
    ]

    // MARK: - 2: Glassmorphic

    static let glassmorphicSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Icon + Text",
                  description: "An HStack with a sparkle icon (with pulse effect) and \"Glass Effect\" label.",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName: "sparkle")
        .font(.system(size: 18))
        .symbolEffect(.pulse, isActive: true)
    Text("Glass Effect")
        .font(.system(size: 18, weight: .medium,
              design: .rounded))
}
.foregroundColor(.white.opacity(0.9))
"""),
        BuildStep(id: 1, title: "Frosted Glass",
                  description: "Use ultraThinMaterial for the iOS frosted-glass blur effect as the background.",
                  codeSnippet: """
.padding(.horizontal, 32)
.padding(.vertical, 18)
.background(
    RoundedRectangle(cornerRadius: 20)
        .fill(.ultraThinMaterial)
)
"""),
        BuildStep(id: 2, title: "Gradient Overlay",
                  description: "Layer a subtle white gradient on top for the glass light refraction look.",
                  codeSnippet: """
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
"""),
        BuildStep(id: 3, title: "Border + Shimmer",
                  description: "Add a gradient border stroke and an animated shimmer sweep that slides across on tap.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 20)
        .stroke(
            LinearGradient(
                colors: [.white.opacity(0.4),
                         .white.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            lineWidth: 1
        )
)
// Shimmer layer offset animates from -200 to 200
"""),
        BuildStep(id: 4, title: "Press & Shadow",
                  description: "Scale down on press with a spring animation, plus a soft blue drop shadow for depth.",
                  codeSnippet: """
.shadow(color: .blue.opacity(0.2),
        radius: 15, y: 8)
.scaleEffect(isPressed ? 0.94 : 1.0)

withAnimation(.spring(response: 0.3,
    dampingFraction: 0.6)) {
    isPressed = true
}
"""),
    ]

    // MARK: - 3: Liquid Morph

    static let liquidMorphSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Label Text",
                  description: "A bold \"Morph\" label in a fixed frame that will sit on top of our liquid blob shape.",
                  codeSnippet: """
Text("Morph")
    .font(.system(size: 20, weight: .bold,
          design: .rounded))
    .foregroundColor(.white)
    .frame(width: 160, height: 60)
"""),
        BuildStep(id: 1, title: "Blob Shape",
                  description: "Create a custom LiquidShape using sine/cosine wobble to generate an organic, ever-changing blob outline.",
                  codeSnippet: """
struct LiquidShape: Shape {
    var phase: CGFloat

    func path(in rect: CGRect) -> Path {
        // 60 points around a circle with
        // triple sine wobble offsets
        let wobble1 = sin(angle * 3 + phase * 2)
            * baseRadius * 0.12
        let wobble2 = cos(angle * 2 + phase * 1.5)
            * baseRadius * 0.08
    }
}
"""),
        BuildStep(id: 2, title: "Gradient Fill",
                  description: "Fill the blob with a warm pink-to-orange gradient for a lava-like appearance.",
                  codeSnippet: """
LiquidShape(phase: morphPhase)
    .fill(
        LinearGradient(
            colors: [
                Color(red: 1, green: 0.4, blue: 0.6),
                Color(red: 1, green: 0.6, blue: 0.2)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
"""),
        BuildStep(id: 3, title: "Glow Shadow",
                  description: "Add a colored shadow that makes the blob appear to emit light.",
                  codeSnippet: """
.shadow(
    color: Color(red: 1, green: 0.4, blue: 0.6)
        .opacity(0.5),
    radius: 20
)
"""),
        BuildStep(id: 4, title: "Animate Everything",
                  description: "Use a Timer to continuously advance the phase, making the blob undulate. On tap, scale it up with a spring bounce.",
                  codeSnippet: """
// Timer drives continuous morph:
.onReceive(timer) { _ in morphPhase += 0.03 }

// Tap bounce:
withAnimation(.spring(response: 0.2,
    dampingFraction: 0.4)) {
    blobScale = 1.15
}
"""),
    ]

    // MARK: - 4: 3D Push

    static let threeDPushSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Button Label",
                  description: "Start with bold \"PRESS ME!\" text in a heavy rounded font with white color.",
                  codeSnippet: """
Text("PRESS ME!")
    .font(.system(size: 20, weight: .heavy,
          design: .rounded))
    .foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Define Colors",
                  description: "Set up a bright green front face and a darker green for the side/shadow that creates the 3D depth.",
                  codeSnippet: """
let frontColor = Color(red: 0.3, green: 0.85,
                       blue: 0.4)
let sideColor = Color(red: 0.15, green: 0.55,
                      blue: 0.2)
"""),
        BuildStep(id: 2, title: "3D Layers",
                  description: "Use a ZStack with the dark side rectangle offset down behind the bright front face rectangle.",
                  codeSnippet: """
.background(
    ZStack {
        // Shadow/side layer
        RoundedRectangle(cornerRadius: 14)
            .fill(sideColor)
            .offset(y: 6)

        // Front face
        RoundedRectangle(cornerRadius: 14)
            .fill(frontColor)
            .offset(y: isPressed ? 4 : 0)
    }
)
"""),
        BuildStep(id: 3, title: "Press Offset",
                  description: "When pressed, offset the text and front face down to meet the side, creating the push-in illusion.",
                  codeSnippet: """
// Front face moves down on press:
.offset(y: isPressed ? 4 : 0)

// Text also moves down:
.offset(y: isPressed ? 4 : 0)
"""),
        BuildStep(id: 4, title: "Spring + Haptics",
                  description: "Use a fast spring animation for the satisfying snap and add rigid haptic feedback on press.",
                  codeSnippet: """
HapticManager.shared.impact(.rigid)
withAnimation(.spring(response: 0.15,
    dampingFraction: 0.5)) {
    isPressed = true
}
DispatchQueue.main.asyncAfter(
    deadline: .now() + 0.15) {
    withAnimation(.spring(response: 0.3,
        dampingFraction: 0.5)) {
        isPressed = false
    }
}
"""),
    ]

    // MARK: - 5: Gradient Wave

    static let gradientWaveSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Flow Label",
                  description: "A bold \"Flow\" text label that will sit on the animated gradient background.",
                  codeSnippet: """
Text("Flow")
    .font(.system(size: 22, weight: .bold,
          design: .rounded))
    .foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Multi-Color Gradient",
                  description: "Create a 4-color gradient from orange through pink to purple, filling a rounded rectangle.",
                  codeSnippet: """
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
                startPoint: UnitPoint(
                    x: gradientOffset, y: 0),
                endPoint: UnitPoint(
                    x: gradientOffset + 1, y: 1)
            )
        )
)
"""),
        BuildStep(id: 2, title: "Border + Shadow",
                  description: "Add a subtle white stroke border and a warm red glow shadow for depth.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 16)
        .stroke(.white.opacity(0.2), lineWidth: 1)
)
.shadow(color: Color(red: 1, green: 0.3, blue: 0.3)
    .opacity(0.5), radius: 15, y: 5)
"""),
        BuildStep(id: 3, title: "Animate the Flow",
                  description: "Use a repeating linear animation to continuously shift the gradient offset, creating the flowing wave effect.",
                  codeSnippet: """
.onAppear {
    withAnimation(.linear(duration: 3)
        .repeatForever(autoreverses: false)) {
        gradientOffset = 1
    }
}
"""),
        BuildStep(id: 4, title: "Press Effect",
                  description: "On press, scale down and tilt with a 3D rotation for a playful interaction.",
                  codeSnippet: """
.scaleEffect(isPressed ? 0.92 : 1.0)
.rotation3DEffect(
    .degrees(isPressed ? 5 : 0),
    axis: (x: 1, y: 0, z: 0)
)
"""),
    ]

    // MARK: - 6: Magnetic Pull

    static let magneticPullSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Icon + Label",
                  description: "An HStack with a magnet icon and \"Attract\" text in bold rounded font.",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName: "magnet.fill")
        .font(.system(size: 18))
        .rotationEffect(
            .degrees(isPressed ? 15 : 0))
    Text("Attract")
        .font(.system(size: 20, weight: .bold,
              design: .rounded))
}
.foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Gradient Capsule",
                  description: "A red-to-orange gradient capsule background for a warm, magnetic feel.",
                  codeSnippet: """
.background(
    Capsule()
        .fill(
            LinearGradient(
                colors: [
                    Color(red: 0.9, green: 0.2,
                          blue: 0.3),
                    Color(red: 1, green: 0.4,
                          blue: 0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
)
"""),
        BuildStep(id: 2, title: "Glow + Border",
                  description: "Add a red glow shadow that intensifies on press, and a white border stroke.",
                  codeSnippet: """
.overlay(
    Capsule()
        .stroke(.white.opacity(0.2), lineWidth: 1)
)
.shadow(color: Color.red.opacity(
    0.3 + glowIntensity * 0.4),
    radius: 15 + glowIntensity * 15)
"""),
        BuildStep(id: 3, title: "Drag Gesture",
                  description: "Add a DragGesture with a maximum distance cap so the button follows your finger with resistance.",
                  codeSnippet: """
.gesture(
    DragGesture()
        .onChanged { value in
            let maxDistance: CGFloat = 30
            let factor = min(distance, maxDistance)
                / max(distance, 1)
            offset = CGSize(
                width: translation.width * factor,
                height: translation.height * factor)
        }
        .onEnded { _ in
            withAnimation(.spring(response: 0.4,
                dampingFraction: 0.3)) {
                offset = .zero
            }
        }
)
"""),
        BuildStep(id: 4, title: "Snap-Back Spring",
                  description: "The button springs back to center with a bouncy, low-damping animation and scales up on press.",
                  codeSnippet: """
.scaleEffect(isPressed ? 1.08 : 1.0)

withAnimation(.spring(response: 0.3,
    dampingFraction: 0.4)) {
    isPressed = true
    glowIntensity = 1
}
"""),
    ]

    // MARK: - 7: Elastic Jelly

    static let elasticJellySteps: [BuildStep] = [
        BuildStep(id: 0, title: "Squish Label",
                  description: "A heavy, bold \"Squish!\" text that will deform with the jelly animation.",
                  codeSnippet: """
Text("Squish!")
    .font(.system(size: 22, weight: .heavy,
          design: .rounded))
    .foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Purple Gradient",
                  description: "A purple-to-pink gradient rounded rectangle with generous corner radius for a soft, squishy appearance.",
                  codeSnippet: """
.background(
    RoundedRectangle(cornerRadius: 24)
        .fill(
            LinearGradient(
                colors: [
                    Color(red: 0.6, green: 0.3,
                          blue: 1),
                    Color(red: 0.9, green: 0.3,
                          blue: 0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
)
"""),
        BuildStep(id: 2, title: "Border + Shadow",
                  description: "Add a white stroke overlay and purple drop shadow for depth.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 24)
        .stroke(.white.opacity(0.2), lineWidth: 1)
)
.shadow(color: Color.purple.opacity(0.4),
        radius: 15, y: 5)
"""),
        BuildStep(id: 3, title: "Jelly Squish Sequence",
                  description: "The magic: a 4-step timed animation. First squash wide, then stretch tall, wobble, then settle back.",
                  codeSnippet: """
// Step 1: Squish down
scaleX = 1.2; scaleY = 0.8; wobble = -3

// Step 2: Bounce overshoot
scaleX = 0.85; scaleY = 1.15; wobble = 3

// Step 3: Second wobble
scaleX = 1.08; scaleY = 0.92; wobble = -1.5

// Step 4: Settle
scaleX = 1; scaleY = 1; wobble = 0
"""),
        BuildStep(id: 4, title: "Apply Transforms",
                  description: "Use independent scaleEffect for X and Y axes plus rotationEffect for the wobble — all driven by spring animations.",
                  codeSnippet: """
.scaleEffect(x: scaleX, y: scaleY)
.rotationEffect(.degrees(wobble))

// Each step uses low-damping springs:
withAnimation(.spring(response: 0.15,
    dampingFraction: 0.3)) { ... }
"""),
    ]

    // MARK: - 8: Particle Burst

    static let particleBurstSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Button Content",
                  description: "An HStack with sparkles icon and \"Burst!\" text in bold black (since the button is bright yellow).",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName: "sparkles")
        .font(.system(size: 18, weight: .bold))
    Text("Burst!")
        .font(.system(size: 20, weight: .bold,
              design: .rounded))
}
.foregroundColor(.black)
"""),
        BuildStep(id: 1, title: "Gold Gradient",
                  description: "A warm yellow-to-orange gradient background in a rounded rectangle.",
                  codeSnippet: """
.background(
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
)
"""),
        BuildStep(id: 2, title: "Particle Model",
                  description: "Define a Particle struct with position, target position, scale, opacity and color — spawned in a circle around the button.",
                  codeSnippet: """
struct Particle: Identifiable {
    let id = UUID()
    var x, y: CGFloat        // start position
    var targetX, targetY: CGFloat  // end position
    var scale: CGFloat
    var opacity: Double
    var color: Color
}
"""),
        BuildStep(id: 3, title: "Emit Particles",
                  description: "On tap, create 20 particles at random angles and distances, then animate them outward while fading.",
                  codeSnippet: """
particles = (0..<20).map { _ in
    let angle = CGFloat.random(
        in: 0...(2 * .pi))
    let distance = CGFloat.random(in: 50...120)
    return Particle(
        x: 0, y: 0,
        targetX: cos(angle) * distance,
        targetY: sin(angle) * distance, ...)
}
withAnimation(.easeOut(duration: 0.6)) {
    showParticles = true
}
"""),
        BuildStep(id: 4, title: "Render & Clean Up",
                  description: "Render particles as colored circles in a ZStack, animate position from center to target, then remove after the animation completes.",
                  codeSnippet: """
ForEach(particles) { particle in
    Circle()
        .fill(particle.color)
        .frame(width: 6 * particle.scale,
               height: 6 * particle.scale)
        .offset(
            x: showParticles
                ? particle.targetX : particle.x,
            y: showParticles
                ? particle.targetY : particle.y)
        .opacity(showParticles ? 0 : particle.opacity)
}
"""),
    ]

    // MARK: - 9: Ripple Effect

    static let rippleEffectSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Icon + Label",
                  description: "An HStack with a water drop icon and \"Ripple\" text in semibold style.",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName: "drop.fill")
        .font(.system(size: 18))
    Text("Ripple")
        .font(.system(size: 20, weight: .semibold,
              design: .rounded))
}
.foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Blue Background",
                  description: "A blue gradient rounded rectangle with padding for the button body.",
                  codeSnippet: """
.background(
    RoundedRectangle(cornerRadius: 14)
        .fill(
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.6,
                          blue: 1),
                    Color(red: 0.1, green: 0.4,
                          blue: 0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
)
.clipShape(RoundedRectangle(cornerRadius: 14))
"""),
        BuildStep(id: 2, title: "Ripple Circle",
                  description: "Add a white circle in a ZStack behind the content that will scale up and fade out.",
                  codeSnippet: """
if showRipple {
    Circle()
        .fill(.white.opacity(rippleOpacity))
        .scaleEffect(rippleScale)
        .frame(width: 200, height: 200)
}
"""),
        BuildStep(id: 3, title: "Animate Ripple",
                  description: "On tap, reset the ripple to small and opaque, then animate it expanding to 2x while fading to transparent.",
                  codeSnippet: """
rippleScale = 0
rippleOpacity = 0.4

withAnimation(.easeOut(duration: 0.6)) {
    rippleScale = 2
    rippleOpacity = 0
}
"""),
        BuildStep(id: 4, title: "Shadow + Scale",
                  description: "Add a blue drop shadow and scale the button down slightly on press for tactile feedback.",
                  codeSnippet: """
.shadow(color: Color.blue.opacity(0.4),
        radius: 12, y: 5)
.scaleEffect(isPressed ? 0.96 : 1.0)
"""),
    ]

    // MARK: - 10: Aurora Borealis

    static let auroraSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Aurora Label",
                  description: "A bold \"Aurora\" text in white over the animated background.",
                  codeSnippet: """
Text("Aurora")
    .font(.system(size: 22, weight: .bold,
          design: .rounded))
    .foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Dark Base Layer",
                  description: "A semi-transparent black rounded rectangle as the base, so the aurora colors show through.",
                  codeSnippet: """
.background(
    ZStack {
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.black.opacity(0.3))
        // Aurora layers go here...
    }
)
"""),
        BuildStep(id: 2, title: "Aurora Gradient",
                  description: "A multi-color green-blue-purple gradient that shifts position using wavePhase for the northern lights movement.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 18)
    .fill(
        LinearGradient(
            colors: [
                Color(red: 0, green: 0.9, blue: 0.6)
                    .opacity(0.6),
                Color(red: 0.2, green: 0.4, blue: 0.9)
                    .opacity(0.6),
                Color(red: 0.5, green: 0.1, blue: 0.8)
                    .opacity(0.6),
            ],
            startPoint: UnitPoint(
                x: wavePhase, y: 0),
            endPoint: UnitPoint(
                x: wavePhase + 0.5, y: 1)
        )
    )
    .hueRotation(.degrees(hueRotation))
"""),
        BuildStep(id: 3, title: "Light Streaks",
                  description: "A secondary gradient layer that creates moving streaks of light across the surface.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 18)
    .fill(
        LinearGradient(
            colors: [.clear, .white.opacity(0.1),
                     .clear],
            startPoint: UnitPoint(
                x: wavePhase * 2, y: 0),
            endPoint: UnitPoint(
                x: wavePhase * 2 + 0.3, y: 1)
        )
    )
"""),
        BuildStep(id: 4, title: "Animate Everything",
                  description: "A Timer advances wavePhase for movement, while hueRotation slowly shifts all colors over 8 seconds.",
                  codeSnippet: """
.onReceive(timer) { _ in
    wavePhase += 0.003
    if wavePhase > 1 { wavePhase = 0 }
}
// Slow hue shift:
withAnimation(.linear(duration: 8)
    .repeatForever(autoreverses: true)) {
    hueRotation = 90
}
"""),
    ]

    // MARK: - 11: Cyber Glitch

    static let cyberGlitchSteps: [BuildStep] = [
        BuildStep(id: 0, title: "RGB Text Layers",
                  description: "Three stacked \"GLITCH\" labels — red channel, cyan channel, and white main text — in monospaced black font.",
                  codeSnippet: """
ZStack {
    Text("GLITCH")
        .foregroundColor(.red.opacity(0.7))
        .offset(x: offsetR, y: -offsetR * 0.5)
    Text("GLITCH")
        .foregroundColor(.cyan.opacity(0.7))
        .offset(x: offsetB, y: offsetB * 0.5)
    Text("GLITCH")
        .foregroundColor(.white)
}
.font(.system(size: 22, weight: .black,
      design: .monospaced))
"""),
        BuildStep(id: 1, title: "Dark Background",
                  description: "A sharp-cornered black rectangle with a subtle red-to-cyan gradient overlay.",
                  codeSnippet: """
.background(
    RoundedRectangle(cornerRadius: 4)
        .fill(Color.black)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.red.opacity(0.15),
                            Color.clear,
                            Color.cyan.opacity(0.15)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        )
)
"""),
        BuildStep(id: 2, title: "Chromatic Border",
                  description: "A gradient stroke from red to cyan for the digital/cyberpunk edge.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 4)
        .stroke(
            LinearGradient(
                colors: [Color.red.opacity(0.5),
                         Color.cyan.opacity(0.5)],
                startPoint: .leading,
                endPoint: .trailing
            ),
            lineWidth: 1
        )
)
"""),
        BuildStep(id: 3, title: "Glitch Sequence",
                  description: "On tap, run 8 rapid-fire random offset changes every 40ms to simulate digital corruption.",
                  codeSnippet: """
for i in 0..<8 {
    DispatchQueue.main.asyncAfter(
        deadline: .now() + Double(i) * 0.04) {
        withAnimation(.linear(duration: 0.03)) {
            offsetR = CGFloat.random(in: -5...5)
            offsetB = CGFloat.random(in: -5...5)
            sliceOffset = CGFloat.random(in: -8...8)
            flickerOpacity = Double.random(
                in: 0.7...1.0)
        }
    }
}
"""),
        BuildStep(id: 4, title: "Settle Back",
                  description: "After the glitch burst, spring everything back to zero for a clean reset.",
                  codeSnippet: """
DispatchQueue.main.asyncAfter(
    deadline: .now() + 0.35) {
    withAnimation(.spring(response: 0.2)) {
        offsetR = 0
        offsetB = 0
        sliceOffset = 0
        flickerOpacity = 1
        isPressed = false
    }
}
"""),
    ]

    // MARK: - 12: Pulse Ring

    static let pulseRingSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Center Circle",
                  description: "A radial gradient circle with a sonar icon as the button center.",
                  codeSnippet: """
ZStack {
    Circle()
        .fill(
            RadialGradient(
                colors: [
                    Color(red: 0.3, green: 0.8,
                          blue: 1),
                    Color(red: 0.1, green: 0.4,
                          blue: 0.9)
                ],
                center: .center,
                startRadius: 0, endRadius: 40
            )
        )
        .frame(width: 80, height: 80)

    Image(systemName: "dot.radiowaves.right")
        .font(.system(size: 28, weight: .bold))
        .foregroundColor(.white)
}
"""),
        BuildStep(id: 1, title: "Idle Ring",
                  description: "A subtle ring that continuously expands and fades in a loop for an idle sonar effect.",
                  codeSnippet: """
Circle()
    .stroke(Color(red: 0.3, green: 0.8, blue: 1)
        .opacity(idleRingOpacity), lineWidth: 1.5)
    .frame(width: 130, height: 130)
    .scaleEffect(idleRingScale)

// On appear:
withAnimation(.easeInOut(duration: 2)
    .repeatForever(autoreverses: true)) {
    idleRingScale = 1.3
    idleRingOpacity = 0
}
"""),
        BuildStep(id: 2, title: "Burst Ring Model",
                  description: "A PulseRing struct that tracks scale and opacity for each emitted ring.",
                  codeSnippet: """
struct PulseRing: Identifiable {
    let id = UUID()
    var scale: CGFloat = 0.5
    var opacity: Double = 0.6
}

@State private var rings: [PulseRing] = []
"""),
        BuildStep(id: 3, title: "Emit 3 Rings",
                  description: "On tap, emit 3 rings with staggered delays. Each expands to 2.5x scale while fading to zero.",
                  codeSnippet: """
for i in 0..<3 {
    DispatchQueue.main.asyncAfter(
        deadline: .now() + Double(i) * 0.15) {
        var ring = PulseRing()
        rings.append(ring)
        withAnimation(.easeOut(duration: 0.8)) {
            rings[index].scale = 2.5
            rings[index].opacity = 0
        }
    }
}
"""),
        BuildStep(id: 4, title: "Glow + Press",
                  description: "Add a cyan glow shadow and scale the center button down on press.",
                  codeSnippet: """
.shadow(color: Color(red: 0.3, green: 0.8,
        blue: 1).opacity(0.5), radius: 20)
.scaleEffect(isPressed ? 0.85 : 1.0)
"""),
    ]

    // MARK: - 13: Shimmer Shine

    static let shimmerShineSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Premium Label",
                  description: "\"Premium\" text with a gold gradient foreground style using a serif font for elegance.",
                  codeSnippet: """
Text("Premium")
    .font(.system(size: 20, weight: .bold,
          design: .serif))
    .foregroundStyle(
        LinearGradient(
            colors: [
                Color(red: 0.85, green: 0.75,
                      blue: 0.55),
                Color(red: 0.95, green: 0.9,
                      blue: 0.7),
                Color(red: 0.85, green: 0.75,
                      blue: 0.55)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    )
"""),
        BuildStep(id: 1, title: "Dark Gold Base",
                  description: "A dark brown/gold gradient background for the luxury feel.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 14)
    .fill(
        LinearGradient(
            colors: [
                Color(red: 0.15, green: 0.12,
                      blue: 0.08),
                Color(red: 0.25, green: 0.2,
                      blue: 0.12),
                Color(red: 0.15, green: 0.12,
                      blue: 0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
"""),
        BuildStep(id: 2, title: "Shimmer Sweep",
                  description: "A bright gradient band that slides across the surface using an animated offset.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 14)
    .fill(
        LinearGradient(
            colors: [.clear, .white.opacity(0.15),
                     .white.opacity(0.25),
                     .white.opacity(0.15), .clear],
            startPoint: UnitPoint(
                x: shimmerOffset - 0.3, y: 0),
            endPoint: UnitPoint(
                x: shimmerOffset, y: 1)
        )
    )
"""),
        BuildStep(id: 3, title: "Gold Border",
                  description: "A gradient gold stroke that varies in opacity for a refined metallic edge.",
                  codeSnippet: """
.overlay(
    RoundedRectangle(cornerRadius: 14)
        .stroke(
            LinearGradient(
                colors: [
                    gold.opacity(0.5),
                    gold.opacity(0.1),
                    gold.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            lineWidth: 1.5
        )
)
"""),
        BuildStep(id: 4, title: "Loop Animation",
                  description: "The shimmer continuously loops across the button surface with a 3-second cycle.",
                  codeSnippet: """
.onAppear {
    withAnimation(.easeInOut(duration: 3)
        .repeatForever(autoreverses: false)
        .delay(1)) {
        shimmerOffset = 2
    }
}
.scaleEffect(isPressed ? 0.95 : 1.0)
"""),
    ]

    // MARK: - 14: Morph Icon

    static let morphIconSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Icon + Label",
                  description: "An HStack with a cycling icon and \"Transform\" text that changes color with each morph.",
                  codeSnippet: """
let icons = ["star.fill", "heart.fill",
    "bolt.fill", "flame.fill", "moon.fill"]

HStack(spacing: 14) {
    Image(systemName: icons[currentIcon])
        .font(.system(size: 24, weight: .bold))
    Text("Transform")
        .font(.system(size: 20, weight: .bold,
              design: .rounded))
}
.foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Color Array",
                  description: "Define matching color pairs for each icon state, used in the gradient background.",
                  codeSnippet: """
let colors: [Color] = [
    Color(red: 0.9, green: 0.3, blue: 0.5),
    Color(red: 1, green: 0.3, blue: 0.3),
    Color(red: 1, green: 0.7, blue: 0),
    Color(red: 1, green: 0.4, blue: 0.1),
    Color(red: 0.5, green: 0.3, blue: 0.9)
]
"""),
        BuildStep(id: 2, title: "Gradient Background",
                  description: "A rounded rectangle filled with a gradient that transitions between the current and next icon's colors.",
                  codeSnippet: """
.background(
    RoundedRectangle(cornerRadius: 18)
        .fill(
            LinearGradient(
                colors: [
                    colors[currentIcon],
                    colors[(currentIcon + 1)
                        % colors.count]
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
)
"""),
        BuildStep(id: 3, title: "Spin Morph",
                  description: "On tap, the icon scales to zero while spinning 180 degrees, then the new icon spins in from zero to full scale.",
                  codeSnippet: """
// Spin out:
withAnimation(.spring(response: 0.2,
    dampingFraction: 0.5)) {
    iconScale = 0
    iconRotation += 180
}
// Switch icon + spin in:
DispatchQueue.main.asyncAfter(
    deadline: .now() + 0.2) {
    currentIcon = (currentIcon + 1)
        % icons.count
    withAnimation(.spring(response: 0.4,
        dampingFraction: 0.5)) {
        iconScale = 1
        iconRotation += 180
    }
}
"""),
        BuildStep(id: 4, title: "Shadow + Polish",
                  description: "A colored shadow that matches the current icon's color, plus scale and border effects.",
                  codeSnippet: """
.shadow(color: colors[currentIcon].opacity(0.5),
        radius: 15, y: 5)
.scaleEffect(isPressed ? 0.92 : 1.0)
.overlay(
    RoundedRectangle(cornerRadius: 18)
        .stroke(.white.opacity(0.2), lineWidth: 1)
)
"""),
    ]

    // MARK: - 15: Retro Pixel

    static let retroPixelSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Pixel Text",
                  description: "\"START\" and \"PRESS\" text in heavy monospaced font with retro green color.",
                  codeSnippet: """
VStack(spacing: 4) {
    Text("START")
        .font(.system(size: 20, weight: .heavy,
              design: .monospaced))
        .foregroundColor(
            Color(red: 0.2, green: 0.8, blue: 0.2))

    Text("\\u{25B6} PRESS \\u{25C0}")
        .font(.system(size: 10, weight: .bold,
              design: .monospaced))
        .foregroundColor(
            Color(red: 0.2, green: 0.8, blue: 0.2)
                .opacity(0.6))
}
"""),
        BuildStep(id: 1, title: "Pixel Border Shape",
                  description: "A custom PixelBorder Shape that creates the retro pixelated rectangle look.",
                  codeSnippet: """
struct PixelBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect,
            cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}
"""),
        BuildStep(id: 2, title: "Green Glow",
                  description: "Fill and stroke the pixel border with green, plus a green glow shadow that intensifies on press.",
                  codeSnippet: """
ZStack {
    PixelBorder()
        .fill(Color(red: 0.2, green: 0.8,
              blue: 0.2).opacity(0.2))
    PixelBorder()
        .stroke(Color(red: 0.2, green: 0.8,
              blue: 0.2), lineWidth: 2)
}
.shadow(color: green.opacity(
    isPressed ? 0.8 : 0.3),
    radius: isPressed ? 15 : 8)
"""),
        BuildStep(id: 3, title: "Score Popup",
                  description: "A floating \"+100\" text that pops up and fades out each time you press — gamified fun!",
                  codeSnippet: """
Text("+\\(pressCount * 100)")
    .font(.system(size: 16, weight: .heavy,
          design: .monospaced))
    .foregroundColor(.green)
    .offset(y: -50 + scoreOffset)
    .opacity(scoreOpacity)

// On press:
withAnimation(.easeOut(duration: 0.6)) {
    scoreOffset = -30
    scoreOpacity = 0
}
"""),
        BuildStep(id: 4, title: "Key Press Feel",
                  description: "A fast, snappy offset and spring animation to simulate a mechanical key press with rigid haptics.",
                  codeSnippet: """
.offset(y: isPressed ? 3 : 0)

HapticManager.shared.impact(.rigid)
withAnimation(.spring(response: 0.1,
    dampingFraction: 0.3)) {
    isPressed = true
}
"""),
    ]

    // MARK: - 16: Holographic

    static let holographicSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Holo Label",
                  description: "A bold \"Holo\" text in white that sits on top of the rainbow effect.",
                  codeSnippet: """
Text("Holo")
    .font(.system(size: 22, weight: .bold,
          design: .rounded))
    .foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Dark Base",
                  description: "A dark purple base rectangle so the holographic rainbow shows on top.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 18)
    .fill(Color(red: 0.15, green: 0.1, blue: 0.2))
"""),
        BuildStep(id: 2, title: "Rainbow Gradient",
                  description: "An AngularGradient cycling through all rainbow colors, with a rotating start angle for the iridescent effect.",
                  codeSnippet: """
RoundedRectangle(cornerRadius: 18)
    .fill(
        AngularGradient(
            colors: [
                .red, .orange, .yellow,
                .green, .cyan, .blue,
                .purple, .red
            ].map { $0.opacity(0.4) },
            center: .center,
            startAngle: .degrees(hueRotation),
            endAngle: .degrees(hueRotation + 360)
        )
    )
"""),
        BuildStep(id: 3, title: "Shimmer + 3D Tilt",
                  description: "A light sweep overlay plus subtle 3D rotation that shifts based on a timer, simulating foil tilting in light.",
                  codeSnippet: """
// Shimmer overlay:
LinearGradient(
    colors: [.clear, .white.opacity(0.2), .clear],
    startPoint: UnitPoint(
        x: shimmerPhase - 0.3, y: 0),
    endPoint: UnitPoint(x: shimmerPhase, y: 1)
)
// 3D tilt:
.rotation3DEffect(.degrees(tiltX * 5),
    axis: (x: 0, y: 1, z: 0))
.rotation3DEffect(.degrees(tiltY * 5),
    axis: (x: 1, y: 0, z: 0))
"""),
        BuildStep(id: 4, title: "Animate Forever",
                  description: "A Timer drives shimmer and tilt with sine/cosine, while hue rotation spins the rainbow every 4 seconds.",
                  codeSnippet: """
.onReceive(timer) { _ in
    shimmerPhase += 0.008
    tiltX = sin(shimmerPhase * 4) * 1.5
    tiltY = cos(shimmerPhase * 3) * 1
}
withAnimation(.linear(duration: 4)
    .repeatForever(autoreverses: false)) {
    hueRotation = 360
}
"""),
    ]

    // MARK: - 17: Typewriter

    static let typewriterSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Text + Cursor",
                  description: "An HStack with the typing text, a blinking cursor rectangle, and invisible spacer text to maintain width.",
                  codeSnippet: """
HStack(spacing: 0) {
    Text(displayText)
        .font(.system(size: 18, weight: .medium,
              design: .monospaced))
        .foregroundColor(
            Color(red: 0.95, green: 0.9, blue: 0.8))

    Rectangle()
        .fill(Color(red: 0.95, green: 0.9,
              blue: 0.8))
        .frame(width: 2, height: 22)
        .opacity(cursorVisible ? 1 : 0)
}
"""),
        BuildStep(id: 1, title: "Key Background",
                  description: "A brown gradient rounded rectangle that looks like a vintage typewriter key, with a raised edge stroke.",
                  codeSnippet: """
ZStack {
    RoundedRectangle(cornerRadius: 8)
        .fill(
            LinearGradient(
                colors: [
                    Color(red: 0.3, green: 0.28,
                          blue: 0.24),
                    Color(red: 0.22, green: 0.2,
                          blue: 0.17)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    RoundedRectangle(cornerRadius: 8)
        .stroke(Color(red: 0.4, green: 0.35,
                blue: 0.28), lineWidth: 2)
        .offset(y: isPressed ? 0 : -2)
}
"""),
        BuildStep(id: 2, title: "Key Press Offset",
                  description: "The button shifts down on press and shadow shrinks to simulate a physical key depression.",
                  codeSnippet: """
.offset(y: isPressed ? 3 : 0)
.shadow(color: .black.opacity(0.4),
        radius: isPressed ? 2 : 5,
        y: isPressed ? 1 : 4)
"""),
        BuildStep(id: 3, title: "Type Animation",
                  description: "On tap, clear the text then add one character at a time with 80ms delays. Each character triggers a tiny key press animation.",
                  codeSnippet: """
displayText = ""
for (index, char) in fullText.enumerated() {
    DispatchQueue.main.asyncAfter(
        deadline: .now()
            + Double(index) * 0.08 + 0.2) {
        displayText += String(char)
        HapticManager.shared.impact(.light)
    }
}
"""),
        BuildStep(id: 4, title: "Blinking Cursor",
                  description: "A Timer toggles cursor visibility every 0.5s when not typing, creating the classic terminal cursor blink.",
                  codeSnippet: """
let timer = Timer.publish(every: 0.5,
    on: .main, in: .common).autoconnect()

.onReceive(timer) { _ in
    if !isTyping {
        cursorVisible.toggle()
    }
}
"""),
    ]

    // MARK: - 18: Circuit Board

    static let circuitBoardSteps: [BuildStep] = [
        BuildStep(id: 0, title: "CPU Label",
                  description: "An HStack with a CPU icon and \"Execute\" text in green monospaced font for the tech look.",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName: "cpu.fill")
        .font(.system(size: 18))
    Text("Execute")
        .font(.system(size: 18, weight: .bold,
              design: .monospaced))
}
.foregroundColor(
    Color(red: 0, green: 1, blue: 0.5))
"""),
        BuildStep(id: 1, title: "Dark PCB Base",
                  description: "A near-black green-tinted rectangle resembling a circuit board surface.",
                  codeSnippet: """
.background(
    RoundedRectangle(cornerRadius: 8)
        .fill(Color(red: 0.05, green: 0.08,
              blue: 0.05))
)
.overlay(
    RoundedRectangle(cornerRadius: 8)
        .stroke(Color(red: 0, green: 1, blue: 0.5)
            .opacity(0.3), lineWidth: 1)
)
"""),
        BuildStep(id: 2, title: "Circuit Traces",
                  description: "Use Canvas to draw circuit trace paths — L-shaped lines with node dots at junctions.",
                  codeSnippet: """
Canvas { context, size in
    let traces: [(CGPoint, CGPoint, CGPoint)] = [
        (CGPoint(x: 0, y: h * 0.3),
         CGPoint(x: w * 0.3, y: h * 0.3),
         CGPoint(x: w * 0.3, y: 0)),
        // ... more traces
    ]
    for (i, trace) in traces.enumerated() {
        var path = Path()
        path.move(to: trace.0)
        path.addLine(to: trace.1)
        path.addLine(to: trace.2)
        context.stroke(
            path.trimmedPath(from: 0, to: progress),
            with: .color(green), lineWidth: 1.5)
    }
}
"""),
        BuildStep(id: 3, title: "Trace Animation",
                  description: "On tap, animate traceProgress from 0 to 1.5 so traces light up sequentially with staggered timing.",
                  codeSnippet: """
traceProgress = 0
withAnimation(.easeIn(duration: 0.8)) {
    traceProgress = 1.5
}
// Each trace starts at different progress:
let progress = min(1, max(0,
    traceProgress - CGFloat(i) * 0.15))
"""),
        BuildStep(id: 4, title: "Glow Pulse",
                  description: "The green glow shadow intensifies during the trace animation, then fades back when traces reset.",
                  codeSnippet: """
.shadow(color: Color(red: 0, green: 1, blue: 0.5)
    .opacity(glowOpacity), radius: 15)

withAnimation(.easeInOut(duration: 0.4)) {
    glowOpacity = 0.8
}
// After traces complete:
withAnimation(.easeOut(duration: 0.5)) {
    glowOpacity = 0.3
    traceProgress = 0
}
"""),
    ]

    // MARK: - 19: Gravity Float

    static let gravityFloatSteps: [BuildStep] = [
        BuildStep(id: 0, title: "Float Label",
                  description: "An HStack with a floating icon and \"Float\" text in semibold rounded font.",
                  codeSnippet: """
HStack(spacing: 10) {
    Image(systemName:
        "arrow.up.and.down.circle.fill")
        .font(.system(size: 20))
        .rotationEffect(.degrees(rotation))
    Text("Float")
        .font(.system(size: 20, weight: .semibold,
              design: .rounded))
}
.foregroundColor(.white)
"""),
        BuildStep(id: 1, title: "Sky Capsule",
                  description: "A blue gradient capsule background with a white stroke border.",
                  codeSnippet: """
.background(
    Capsule()
        .fill(
            LinearGradient(
                colors: [
                    Color(red: 0.5, green: 0.7,
                          blue: 1),
                    Color(red: 0.3, green: 0.4,
                          blue: 0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
)
.overlay(
    Capsule()
        .stroke(.white.opacity(0.2), lineWidth: 1)
)
"""),
        BuildStep(id: 2, title: "Orbiting Dots",
                  description: "Four small circles orbiting around the button using sine/cosine positioning driven by a Timer.",
                  codeSnippet: """
ForEach(0..<4, id: \\.self) { i in
    Circle()
        .fill(Color(red: 0.5, green: 0.7, blue: 1)
            .opacity(0.4))
        .frame(width: 4, height: 4)
        .offset(
            x: cos(orbitAngle
                + Double(i) * .pi / 2) * 70,
            y: sin(orbitAngle
                + Double(i) * .pi / 2) * 25)
}
"""),
        BuildStep(id: 3, title: "Idle Float",
                  description: "A repeating ease-in-out animation that gently bobs the button up and down with dynamic shadow changes.",
                  codeSnippet: """
withAnimation(.easeInOut(duration: 2.5)
    .repeatForever(autoreverses: true)) {
    floatY = -8
    shadowRadius = 18
    shadowY = 12
}
"""),
        BuildStep(id: 4, title: "Launch Tap",
                  description: "On tap, launch the button upward with a spring, spin the icon 360 degrees, then float back down.",
                  codeSnippet: """
// Launch up:
withAnimation(.spring(response: 0.3,
    dampingFraction: 0.4)) {
    floatY = -30
    rotation = 360
}
// Float back:
DispatchQueue.main.asyncAfter(
    deadline: .now() + 0.3) {
    withAnimation(.spring(response: 0.8,
        dampingFraction: 0.5)) {
        floatY = 0
    }
}
"""),
    ]
}
