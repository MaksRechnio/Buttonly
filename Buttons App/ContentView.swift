import SwiftUI

struct ContentView: View {
    @State private var showWelcome = true
    @State private var selectedButton: ButtonDesign?
    @State private var showFullScreen = false
    @State private var showTutorial = false
    @State private var selectedLesson: TutorialLesson?
    @State private var showBuildTutorial = false
    @State private var buildDesign: ButtonDesign?
    @Namespace private var animation

    var body: some View {
        ZStack {
            // Futuristic background
            FuturisticBackground()
                .ignoresSafeArea()

            if showWelcome {
                WelcomeView(onContinue: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.85)) {
                        showWelcome = false
                    }
                })
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .move(edge: .top).combined(with: .opacity)
                ))
            } else if showBuildTutorial, let design = buildDesign {
                ButtonBuildTutorialView(
                    design: design,
                    onBack: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showBuildTutorial = false
                            buildDesign = nil
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.9).combined(with: .opacity)
                ))
            } else if showFullScreen, let selected = selectedButton {
                FullScreenButtonView(
                    selectedButton: selected,
                    namespace: animation,
                    onBack: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showFullScreen = false
                            selectedButton = nil
                        }
                    },
                    onSelectButton: { button in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            selectedButton = button
                        }
                    },
                    onBuildIt: { design in
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            buildDesign = design
                            showBuildTutorial = true
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.9).combined(with: .opacity)
                ))
            } else if showTutorial, let lesson = selectedLesson {
                TutorialLessonView(
                    lesson: lesson,
                    onBack: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            selectedLesson = nil
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.9).combined(with: .opacity)
                ))
            } else if showTutorial {
                TutorialMenuView(
                    onBack: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showTutorial = false
                        }
                    },
                    onSelectLesson: { lesson in
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            selectedLesson = lesson
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .opacity
                ))
            } else {
                ButtonGridView(
                    namespace: animation,
                    onSelect: { button in
                        selectedButton = button
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showFullScreen = true
                        }
                    },
                    onTutorial: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showTutorial = true
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .opacity
                ))
            }
        }
    }
}

#Preview {
    ContentView()
}
