import SwiftUI

struct ButtonGridView: View {
    var namespace: Namespace.ID
    let onSelect: (ButtonDesign) -> Void
    var onTutorial: () -> Void = {}

    @State private var headerAppeared = false
    @State private var bannerAppeared = false

    let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Buttonly")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("20 Unique Designs")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                    }
                    Spacer()

                    Image("LogoDark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .cyan.opacity(0.3), radius: 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 10)
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : -20)
            }

            // Grid
            ScrollView(.vertical, showsIndicators: false) {
                // Tutorial Banner
                Button(action: {
                    HapticManager.shared.impact(.medium)
                    onTutorial()
                }) {
                    GlassCard(cornerRadius: 18, opacity: 0.15) {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.cyan, .purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 44, height: 44)

                                Image(systemName: "book.fill")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading, spacing: 3) {
                                Text("Building Tutorial")
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)

                                Text("Learn step by step")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.5))
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        .padding(14)
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .opacity(bannerAppeared ? 1 : 0)
                .offset(y: bannerAppeared ? 0 : 20)

                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(ButtonDesign.allDesigns) { design in
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            onSelect(design)
                        }) {
                            ButtonPreviewCard(design: design)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
                .padding(.top, 8)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                headerAppeared = true
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.25)) {
                bannerAppeared = true
            }
        }
    }
}
