import SwiftUI

struct TutorialMenuView: View {
    let onBack: () -> Void
    let onSelectLesson: (TutorialLesson) -> Void

    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
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
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .padding(.bottom, 8)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : -20)

            // Title
            VStack(alignment: .leading, spacing: 4) {
                Text("Building Tutorial")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("Learn SwiftUI buttons step by step")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : -10)

            // Lesson List
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(Array(TutorialLesson.allLessons.enumerated()), id: \.element.id) { index, lesson in
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            onSelectLesson(lesson)
                        }) {
                            lessonCard(lesson: lesson)
                        }
                        .buttonStyle(.plain)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 30)
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.8)
                            .delay(Double(index) * 0.05 + 0.15),
                            value: appeared
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appeared = true
            }
        }
    }

    // MARK: - Lesson Card

    private func lessonCard(lesson: TutorialLesson) -> some View {
        GlassCard(cornerRadius: 18, opacity: 0.1) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [lesson.accentColor1, lesson.accentColor2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 48, height: 48)

                    Image(systemName: lesson.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text("\(lesson.id).")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundColor(lesson.accentColor1)

                        Text(lesson.title)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }

                    Text(lesson.subtitle)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(16)
        }
    }
}
