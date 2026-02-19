import SwiftUI
import Combine

struct WelcomeView: View {
    let onContinue: () -> Void

    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showButton = false
    @State private var rotationX: Double = 0
    @State private var rotationY: Double = 0
    @State private var cubeScale: CGFloat = 0.3
    @State private var cubeOpacity: Double = 0
    @State private var glowPhase: CGFloat = 0
    @State private var floatOffset: CGFloat = 0
    @State private var timerCancellable: Cancellable?

    private let timerPublisher = Timer.publish(every: 1/30, on: .main, in: .common)

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            // 3D Animated Object
            ZStack {
                // Glow ring behind the cube
                ForEach(0..<3, id: \.self) { i in
                    Ellipse()
                        .stroke(
                            AngularGradient(
                                colors: [.cyan, .purple, .blue, .cyan],
                                center: .center,
                                startAngle: .degrees(glowPhase * 60 + Double(i) * 120),
                                endAngle: .degrees(glowPhase * 60 + Double(i) * 120 + 360)
                            ),
                            lineWidth: 2
                        )
                        .frame(width: 200 + CGFloat(i) * 30,
                               height: 60 + CGFloat(i) * 10)
                        .rotation3DEffect(.degrees(70), axis: (x: 1, y: 0, z: 0))
                        .rotationEffect(.degrees(Double(i) * 30 + glowPhase * 20))
                        .opacity(0.4 - Double(i) * 0.1)
                        .blur(radius: CGFloat(i) * 2)
                }

                // 3D Cube made of SwiftUI shapes
                ZStack {
                    // Front face
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.3, green: 0.5, blue: 1).opacity(0.6),
                                    Color(red: 0.5, green: 0.2, blue: 0.9).opacity(0.4)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                        .frame(width: 100, height: 100)
                        .rotation3DEffect(
                            .degrees(rotationX),
                            axis: (x: 0, y: 1, z: 0),
                            perspective: 0.5
                        )
                        .rotation3DEffect(
                            .degrees(rotationY * 0.3),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )

                    // Button icon inside
                    Image(systemName: "hand.tap.fill")
                        .font(.system(size: 36, weight: .light))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .cyan],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotation3DEffect(
                            .degrees(rotationX),
                            axis: (x: 0, y: 1, z: 0),
                            perspective: 0.5
                        )
                        .rotation3DEffect(
                            .degrees(rotationY * 0.3),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )
                        .shadow(color: .cyan.opacity(0.6), radius: 20)
                }
                .offset(y: floatOffset)
                .scaleEffect(cubeScale)
                .opacity(cubeOpacity)
            }
            .frame(height: 250)

            // Logo + Title
            VStack(spacing: 20) {
                Image("LogoDark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .cyan.opacity(0.4), radius: 20)
                    .shadow(color: .purple.opacity(0.3), radius: 30)

                VStack(spacing: 4) {
                    Text("Buttonly")
                        .font(.system(size: 46, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, Color(red: 0.7, green: 0.85, blue: 1)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
            }
            .opacity(showTitle ? 1 : 0)
            .offset(y: showTitle ? 0 : 30)

            Text("Explore 20 beautifully crafted button designs\nwith unique animations & interactions")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .opacity(showSubtitle ? 1 : 0)
                .offset(y: showSubtitle ? 0 : 20)

            Spacer()

            // Enter button
            Button(action: {
                HapticManager.shared.impact(.medium)
                onContinue()
            }) {
                HStack(spacing: 12) {
                    Text("Explore Collection")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))

                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 18)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.3, green: 0.5, blue: 1),
                                    Color(red: 0.5, green: 0.2, blue: 0.9)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .blue.opacity(0.4), radius: 20, y: 10)
            }
            .opacity(showButton ? 1 : 0)
            .offset(y: showButton ? 0 : 30)
            .scaleEffect(showButton ? 1 : 0.8)

            Spacer()
                .frame(height: 60)
        }
        .onAppear {
            timerCancellable = timerPublisher.connect()
            startAnimations()
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
        .onReceive(timerPublisher) { _ in
            glowPhase += 0.02
            floatOffset = sin(glowPhase * 2) * 8
        }
    }

    private func startAnimations() {
        // 3D cube entrance
        withAnimation(.spring(response: 1.2, dampingFraction: 0.7)) {
            cubeScale = 1.0
            cubeOpacity = 1.0
        }

        // Start continuous rotation
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            rotationX = 360
        }
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            rotationY = 30
        }

        // Title
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.5)) {
            showTitle = true
        }

        // Subtitle
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.8)) {
            showSubtitle = true
        }

        // Button
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(1.2)) {
            showButton = true
        }
    }
}

#Preview {
    ZStack {
        FuturisticBackground()
            .ignoresSafeArea()
        WelcomeView(onContinue: {})
    }
}
