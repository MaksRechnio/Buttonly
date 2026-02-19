import SwiftUI

struct TutorialLessonView: View {
    let lesson: TutorialLesson
    let onBack: () -> Void

    @State private var currentPage = 0
    @State private var appeared = false
    @State private var direction: Edge = .trailing

    private var isLastPage: Bool {
        currentPage >= lesson.pages.count - 1
    }

    private var progress: CGFloat {
        guard lesson.pages.count > 1 else { return 1 }
        return CGFloat(currentPage + 1) / CGFloat(lesson.pages.count)
    }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top bar (VStack, not ZStack overlay)
            VStack(spacing: 12) {
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

                    Text(lesson.title)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.horizontal, 20)

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                            .frame(height: 4)

                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [lesson.accentColor1, lesson.accentColor2],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geo.size.width * progress, height: 4)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: progress)
                    }
                }
                .frame(height: 4)
                .padding(.horizontal, 20)
            }
            .padding(.top, 60)
            .padding(.bottom, 8)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : -20)

            // MARK: - Page title
            HStack {
                Text(lesson.pages[currentPage].title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(lesson.accentColor1)

                Spacer()

                Text("\(currentPage + 1)/\(lesson.pages.count)")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .padding(.bottom, 8)

            // MARK: - Page content (single page, no TabView)
            TutorialPageView(
                page: lesson.pages[currentPage],
                accentColor1: lesson.accentColor1,
                accentColor2: lesson.accentColor2
            )
            .id(currentPage)
            .transition(.asymmetric(
                insertion: .move(edge: direction).combined(with: .opacity),
                removal: .move(edge: direction == .trailing ? .leading : .trailing).combined(with: .opacity)
            ))

            // MARK: - "Got It" button pinned to bottom
            Button(action: {
                HapticManager.shared.impact(.medium)
                if isLastPage {
                    onBack()
                } else {
                    direction = .trailing
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        currentPage += 1
                    }
                }
            }) {
                Text(isLastPage ? "Complete Lesson" : "Got It")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        colors: [lesson.accentColor1, lesson.accentColor2],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )

                            RoundedRectangle(cornerRadius: 16)
                                .fill(.ultraThinMaterial)
                                .opacity(0.15)

                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        }
                    )
                    .shadow(color: lesson.accentColor1.opacity(0.3), radius: 12, y: 4)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 36)
            .padding(.top, 8)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appeared = true
            }
        }
    }
}
