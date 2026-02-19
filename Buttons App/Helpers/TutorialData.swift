import SwiftUI

// MARK: - Live Demo Types

enum LiveDemoType: Equatable, Hashable {
    case threeDPush
    case neumorphic
    case neonGlow
    case gradientWave
    case glassmorphic
}

// MARK: - Content Block

enum ContentBlock: Identifiable, Equatable, Hashable {
    case heading(String)
    case text(String)
    case code(String)
    case tip(String)
    case liveDemo(LiveDemoType)
    case definition(term: String, explanation: String)
    case visualExample(icon: String, caption: String)

    var id: Int { hashValue }
}

// MARK: - Tutorial Page

struct TutorialPage: Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
    let blocks: [ContentBlock]
}

// MARK: - Tutorial Lesson

struct TutorialLesson: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let icon: String
    let accentColor1: Color
    let accentColor2: Color
    let pages: [TutorialPage]
}

// MARK: - All Lessons

extension TutorialLesson {
    static let allLessons: [TutorialLesson] = [
        // MARK: Lesson 1 — The Basics
        TutorialLesson(
            id: 1,
            title: "The Basics",
            subtitle: "Your first button",
            icon: "play.circle.fill",
            accentColor1: .cyan,
            accentColor2: .blue,
            pages: [
                TutorialPage(title: "Welcome!", blocks: [
                    .heading("Your First SwiftUI Button"),
                    .visualExample(icon: "hand.tap.fill", caption: "Buttons are the building blocks of every app"),
                    .text("Every app needs buttons. In SwiftUI, creating one is surprisingly simple — just a few lines of code."),
                    .text("Let's start with the most basic button possible and build from there.")
                ]),
                TutorialPage(title: "The Button View", blocks: [
                    .heading("Button Anatomy"),
                    .text("A SwiftUI Button has two parts: an action (what happens on tap) and a label (what it looks like)."),
                    .definition(term: "View", explanation: "A View is anything you can see on screen — text, images, buttons, shapes. In SwiftUI, you build your UI by combining small views into bigger ones."),
                    .code("""
                    Button(action: {
                        print("Tapped!")
                    }) {
                        Text("Tap Me")
                    }
                    """)
                ]),
                TutorialPage(title: "How It Works", blocks: [
                    .heading("Breaking It Down"),
                    .definition(term: "Closure", explanation: "A closure is a chunk of code you pass around like a value. The { } braces after 'action:' contain a closure — it's the code that runs when the button is tapped."),
                    .text("• action: — A closure that runs when the user taps\n• The trailing closure — Your button's visual content\n• Text(\"Tap Me\") — A simple text label"),
                    .tip("Try changing the text inside Text() to say your name!")
                ]),
                TutorialPage(title: "Adding a Title", blocks: [
                    .heading("Styled Text"),
                    .definition(term: "Modifier", explanation: "A modifier is a method you chain onto a view to change how it looks or behaves. Think of it like adding filters — each one transforms the view step by step."),
                    .text("You can style the text with modifiers like .font() and .foregroundColor()."),
                    .code("""
                    Button(action: {
                        print("Hello!")
                    }) {
                        Text("Hello")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    """),
                    .tip("SwiftUI modifiers chain together — each one transforms the view above it.")
                ])
            ]
        ),

        // MARK: Lesson 2 — Styling
        TutorialLesson(
            id: 2,
            title: "Styling",
            subtitle: "Making it look real",
            icon: "paintbrush.fill",
            accentColor1: .purple,
            accentColor2: .pink,
            pages: [
                TutorialPage(title: "Beyond Plain Text", blocks: [
                    .heading("Real Buttons Need Style"),
                    .visualExample(icon: "paintbrush.pointed.fill", caption: "Transform plain text into a polished button"),
                    .text("A text-only button doesn't look tappable. Let's add padding, a background color, and rounded corners.")
                ]),
                TutorialPage(title: "Padding", blocks: [
                    .heading("Give It Space"),
                    .definition(term: "Padding", explanation: "Padding is invisible space added around a view's content. It pushes the edges outward so the content doesn't feel cramped against its background or border."),
                    .text("Padding adds breathing room around your text. Without it, the background hugs the text too tightly."),
                    .code("""
                    Text("Styled")
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    """),
                    .tip("Try .padding(20) for equal padding on all sides.")
                ]),
                TutorialPage(title: "Background & Shape", blocks: [
                    .heading("Color & Corners"),
                    .text("Add a background color and round the corners to create a proper button shape."),
                    .code("""
                    Text("Tap Me")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(12)
                    """)
                ]),
                TutorialPage(title: "The Full Button", blocks: [
                    .heading("Putting It Together"),
                    .visualExample(icon: "checkmark.rectangle.fill", caption: "A complete styled button"),
                    .code("""
                    Button(action: {
                        print("Styled!")
                    }) {
                        Text("Styled Button")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(Color.blue)
                            .cornerRadius(14)
                    }
                    """),
                    .tip("Modifier order matters! .background before .cornerRadius clips the color to the shape.")
                ])
            ]
        ),

        // MARK: Lesson 3 — Shadows
        TutorialLesson(
            id: 3,
            title: "Shadows",
            subtitle: "Adding depth",
            icon: "square.stack.3d.up.fill",
            accentColor1: .indigo,
            accentColor2: .purple,
            pages: [
                TutorialPage(title: "Flat vs Deep", blocks: [
                    .heading("Why Shadows Matter"),
                    .visualExample(icon: "square.stack.3d.down.right.fill", caption: "Shadows create the illusion of depth"),
                    .text("Shadows make buttons feel like real, tappable objects. They create the illusion that your button floats above the surface.")
                ]),
                TutorialPage(title: "The .shadow Modifier", blocks: [
                    .heading("Adding a Shadow"),
                    .text("The .shadow() modifier takes a color, radius, and x/y offset."),
                    .code("""
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 10,
                        x: 0,
                        y: 5
                    )
                    """),
                    .text("• radius — How blurry the shadow is\n• x, y — The shadow's offset direction\n• color — Usually black with low opacity")
                ]),
                TutorialPage(title: "Colored Shadows", blocks: [
                    .heading("Glow Effects"),
                    .text("Use colored shadows to create a glow effect that matches your button."),
                    .code("""
                    Text("Glow")
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .background(Color.cyan)
                        .cornerRadius(14)
                        .shadow(
                            color: .cyan.opacity(0.6),
                            radius: 15,
                            y: 4
                        )
                    """),
                    .tip("Try layering multiple .shadow() modifiers for a richer look!")
                ]),
                TutorialPage(title: "Neumorphic Style", blocks: [
                    .heading("Two Shadows = Neumorphism"),
                    .text("Combine a dark shadow and a light shadow to create the popular neumorphic style."),
                    .liveDemo(.neumorphic)
                ])
            ]
        ),

        // MARK: Lesson 4 — 3D Push
        TutorialLesson(
            id: 4,
            title: "3D Push",
            subtitle: "Duolingo-style button",
            icon: "cube.fill",
            accentColor1: .green,
            accentColor2: .mint,
            pages: [
                TutorialPage(title: "The 3D Effect", blocks: [
                    .heading("Buttons That Push Down"),
                    .visualExample(icon: "cube.fill", caption: "3D buttons feel physical and satisfying"),
                    .text("Ever noticed how Duolingo's buttons look 3D and push down when tapped? We'll build exactly that.")
                ]),
                TutorialPage(title: "@State & Animation", blocks: [
                    .heading("Tracking Press State"),
                    .definition(term: "@State", explanation: "@State is a special keyword that tells SwiftUI to watch this variable. When it changes, SwiftUI automatically redraws the view — that's how animations and interactions work."),
                    .text("We need a boolean to track whether the button is pressed, and animate between states."),
                    .code("""
                    @State private var isPressed = false

                    // Toggle on tap:
                    withAnimation(.spring(
                        response: 0.15,
                        dampingFraction: 0.5
                    )) {
                        isPressed = true
                    }
                    """)
                ]),
                TutorialPage(title: "ZStack Layering", blocks: [
                    .heading("Building the 3D Shape"),
                    .definition(term: "ZStack", explanation: "A ZStack layers views on top of each other like stacking cards. The first view is at the back, the last is on top. Great for creating depth effects."),
                    .text("Use a ZStack to layer a darker \"side\" behind the front face. Offset the front on press."),
                    .code("""
                    ZStack {
                        // Bottom shadow layer
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green.opacity(0.5))
                            .offset(y: 6)

                        // Front face
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green)
                            .offset(y: isPressed ? 4 : 0)
                    }
                    """)
                ]),
                TutorialPage(title: "Live Example", blocks: [
                    .heading("Try It!"),
                    .text("Here's the actual 3D Push button from this app. Tap it and watch the spring animation!"),
                    .liveDemo(.threeDPush),
                    .tip("Notice how the spring animation gives it a bouncy, physical feel.")
                ])
            ]
        ),

        // MARK: Lesson 5 — Icons & Text
        TutorialLesson(
            id: 5,
            title: "Icons & Text",
            subtitle: "HStack + SF Symbols",
            icon: "star.circle.fill",
            accentColor1: .orange,
            accentColor2: .yellow,
            pages: [
                TutorialPage(title: "Beyond Text", blocks: [
                    .heading("Buttons With Icons"),
                    .visualExample(icon: "star.circle.fill", caption: "Icons make buttons instantly recognizable"),
                    .text("Most real buttons combine an icon with text. SwiftUI makes this easy with HStack and SF Symbols.")
                ]),
                TutorialPage(title: "HStack Layout", blocks: [
                    .heading("Side by Side"),
                    .definition(term: "HStack", explanation: "An HStack arranges views horizontally in a row, from left to right. It's one of three layout stacks — HStack (horizontal), VStack (vertical), and ZStack (layered)."),
                    .code("""
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                        Text("Favorite")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.orange)
                    .cornerRadius(12)
                    """)
                ]),
                TutorialPage(title: "SF Symbols", blocks: [
                    .heading("Apple's Icon Library"),
                    .text("SF Symbols gives you 5,000+ free icons that match Apple's design.\n\n• Use Image(systemName: \"icon.name\")\n• They scale with .font() automatically\n• Common ones: heart.fill, star.fill, plus, trash, pencil"),
                    .tip("Download the SF Symbols app from Apple to browse all available icons!")
                ]),
                TutorialPage(title: "Label Shortcut", blocks: [
                    .heading("Even Simpler"),
                    .text("SwiftUI's Label view combines text and icon in one line."),
                    .code("""
                    Button(action: { }) {
                        Label("Download",
                              systemImage: "arrow.down.circle.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                    """)
                ])
            ]
        ),

        // MARK: Lesson 6 — Gradients
        TutorialLesson(
            id: 6,
            title: "Gradients",
            subtitle: "Multi-color backgrounds",
            icon: "paintpalette.fill",
            accentColor1: .pink,
            accentColor2: .orange,
            pages: [
                TutorialPage(title: "Solid is Boring", blocks: [
                    .heading("Add Some Color Flow"),
                    .visualExample(icon: "paintpalette.fill", caption: "Gradients bring energy and depth to buttons"),
                    .text("Gradients make buttons feel modern and dynamic. SwiftUI offers three types: Linear, Radial, and Angular.")
                ]),
                TutorialPage(title: "LinearGradient", blocks: [
                    .heading("The Most Common Gradient"),
                    .text("Colors flow from one point to another in a straight line."),
                    .code("""
                    .background(
                        LinearGradient(
                            colors: [.pink, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    """),
                    .tip("Try different start/end points: .top, .bottom, .topLeading, .bottomTrailing")
                ]),
                TutorialPage(title: "Animated Gradient", blocks: [
                    .heading("Moving Colors"),
                    .definition(term: ".onAppear", explanation: ".onAppear is a modifier that runs code the moment a view appears on screen. It's the perfect place to kick off animations that should start immediately."),
                    .text("Animate a gradient offset to create a flowing wave effect."),
                    .code("""
                    @State var offset: CGFloat = 0

                    .onAppear {
                        withAnimation(
                            .linear(duration: 3)
                            .repeatForever(autoreverses: false)
                        ) {
                            offset = 1
                        }
                    }
                    """)
                ]),
                TutorialPage(title: "Live Example", blocks: [
                    .heading("Gradient Wave Button"),
                    .text("Watch the gradient colors flow continuously across this button."),
                    .liveDemo(.gradientWave),
                    .tip("This uses .repeatForever to keep the animation going endlessly.")
                ])
            ]
        ),

        // MARK: Lesson 7 — Borders & Overlays
        TutorialLesson(
            id: 7,
            title: "Borders & Overlays",
            subtitle: "Outlines and layers",
            icon: "square.on.square",
            accentColor1: .teal,
            accentColor2: .cyan,
            pages: [
                TutorialPage(title: "Border Styles", blocks: [
                    .heading("Outlined Buttons"),
                    .visualExample(icon: "square.dashed", caption: "Borders create clean, minimal button styles"),
                    .text("Sometimes you want just an outline instead of a filled background. Use .overlay with .stroke.")
                ]),
                TutorialPage(title: "The .overlay Modifier", blocks: [
                    .heading("Layering On Top"),
                    .text("Overlay places a view on top of another, perfect for borders."),
                    .code("""
                    Text("Outlined")
                        .font(.headline)
                        .foregroundColor(.cyan)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                    """)
                ]),
                TutorialPage(title: "Gradient Borders", blocks: [
                    .heading("Fancy Outlines"),
                    .text("Combine gradients with strokes for eye-catching borders."),
                    .code("""
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [.cyan, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                    """),
                    .liveDemo(.glassmorphic)
                ]),
                TutorialPage(title: "Glassmorphism", blocks: [
                    .heading("Glass Effect"),
                    .text("Combine .ultraThinMaterial with a subtle border to create the trendy glass look."),
                    .code("""
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                .white.opacity(0.2),
                                lineWidth: 1
                            )
                    )
                    """),
                    .tip("This is exactly how the GlassCard component in this app works!")
                ])
            ]
        ),

        // MARK: Lesson 8 — Press Animation
        TutorialLesson(
            id: 8,
            title: "Press Animation",
            subtitle: "The isPressed pattern",
            icon: "hand.tap.fill",
            accentColor1: Color(red: 0.3, green: 0.3, blue: 0.8),
            accentColor2: Color(red: 0.5, green: 0.3, blue: 0.9),
            pages: [
                TutorialPage(title: "Feedback Matters", blocks: [
                    .heading("Respond to Touch"),
                    .visualExample(icon: "hand.point.up.left.fill", caption: "Great buttons respond instantly to touch"),
                    .text("Great buttons give instant visual feedback when pressed. The @State + isPressed pattern is the foundation of interactive buttons.")
                ]),
                TutorialPage(title: "The Pattern", blocks: [
                    .heading("isPressed Toggle"),
                    .text("Set isPressed to true on tap, then reset it after a short delay."),
                    .code("""
                    @State private var isPressed = false

                    Button(action: {
                        withAnimation(.spring(
                            response: 0.3,
                            dampingFraction: 0.5
                        )) {
                            isPressed = true
                        }
                        // Reset after delay
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 0.2
                        ) {
                            withAnimation(.spring()) {
                                isPressed = false
                            }
                        }
                    }) {
                        // label
                    }
                    """)
                ]),
                TutorialPage(title: "Visual Changes", blocks: [
                    .heading("What To Animate"),
                    .text("Common press effects:\n• Scale down: .scaleEffect(isPressed ? 0.92 : 1.0)\n• Shadow change: reduce shadow on press\n• Color shift: slightly darken the background\n• Offset: move down a few points"),
                    .code("""
                    .scaleEffect(isPressed ? 0.92 : 1.0)
                    .shadow(
                        radius: isPressed ? 4 : 10,
                        y: isPressed ? 2 : 5
                    )
                    """)
                ]),
                TutorialPage(title: "Live Example", blocks: [
                    .heading("Neumorphic Press"),
                    .text("Watch how the shadows invert when you press this button — the highlight and dark shadow swap to create an inset look."),
                    .liveDemo(.neumorphic),
                    .tip("Pair visual feedback with haptics (HapticManager) for the best feel!")
                ])
            ]
        ),

        // MARK: Lesson 9 — Continuous Animation
        TutorialLesson(
            id: 9,
            title: "Continuous Animation",
            subtitle: ".onAppear + .repeatForever",
            icon: "wand.and.stars",
            accentColor1: .cyan,
            accentColor2: .purple,
            pages: [
                TutorialPage(title: "Always Moving", blocks: [
                    .heading("Animations That Never Stop"),
                    .visualExample(icon: "wand.and.stars", caption: "Continuous animations add life to your buttons"),
                    .text("Some buttons glow, pulse, or shimmer continuously. This is done by starting an animation in .onAppear that repeats forever.")
                ]),
                TutorialPage(title: "The Recipe", blocks: [
                    .heading(".onAppear + .repeatForever"),
                    .code("""
                    @State private var glowAmount: CGFloat = 0

                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true)
                        ) {
                            glowAmount = 1
                        }
                    }
                    """),
                    .text("The state starts at 0 and animates to 1, then back to 0, forever. Use this value to drive visual changes.")
                ]),
                TutorialPage(title: "Driving Visuals", blocks: [
                    .heading("What To Animate"),
                    .text("Use the animated value to control any visual property:"),
                    .code("""
                    // Pulsing shadow
                    .shadow(
                        color: .cyan.opacity(
                            0.3 + glowAmount * 0.4
                        ),
                        radius: 10 + glowAmount * 10
                    )

                    // Pulsing scale
                    .scaleEffect(1.0 + glowAmount * 0.03)
                    """),
                    .tip("Keep continuous animations subtle — a little goes a long way!")
                ]),
                TutorialPage(title: "Live Example", blocks: [
                    .heading("Neon Glow Button"),
                    .text("This button uses a Combine timer at 30 FPS for smooth continuous animation of its glowing border."),
                    .liveDemo(.neonGlow),
                    .tip("For complex animations, a Timer.publish gives you more control than .repeatForever.")
                ])
            ]
        ),

        // MARK: Lesson 10 — Build Your Own
        TutorialLesson(
            id: 10,
            title: "Build Your Own",
            subtitle: "Combine everything",
            icon: "hammer.fill",
            accentColor1: .yellow,
            accentColor2: .orange,
            pages: [
                TutorialPage(title: "You're Ready!", blocks: [
                    .heading("Put It All Together"),
                    .visualExample(icon: "hammer.fill", caption: "Time to create something unique"),
                    .text("You've learned every technique used in this app's 20 buttons. Now it's time to build your own unique button!")
                ]),
                TutorialPage(title: "Starter Template", blocks: [
                    .heading("Start Here"),
                    .text("Copy this template and customize it with everything you've learned."),
                    .code("""
                    struct MyButton: View {
                        @State private var isPressed = false
                        @State private var glowPhase: CGFloat = 0

                        var body: some View {
                            Button(action: {
                                withAnimation(.spring(
                                    response: 0.3,
                                    dampingFraction: 0.6
                                )) {
                                    isPressed = true
                                }
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 0.2
                                ) {
                                    withAnimation(.spring()) {
                                        isPressed = false
                                    }
                                }
                            }) {
                                // Your label here
                            }
                        }
                    }
                    """)
                ]),
                TutorialPage(title: "Ideas to Try", blocks: [
                    .heading("Challenges"),
                    .text("1. Build a \"Like\" button with a heart that fills in and scales up when tapped\n\n2. Create a download button that shows a progress ring\n\n3. Make a toggle button that morphs between two states\n\n4. Design a button with particle effects on tap"),
                    .tip("Look at the source code of buttons in this app for inspiration!")
                ]),
                TutorialPage(title: "What You Learned", blocks: [
                    .heading("Recap"),
                    .visualExample(icon: "graduationcap.fill", caption: "You've mastered SwiftUI button techniques!"),
                    .text("You now know how to:\n\n• Create buttons with Button + Text\n• Style with padding, background, cornerRadius\n• Add depth with shadows\n• Build 3D effects with ZStack\n• Use SF Symbols for icons\n• Apply gradients for color\n• Create borders with overlay + stroke\n• Animate presses with @State\n• Run continuous animations\n• Combine techniques for unique designs"),
                    .tip("The best way to learn is to experiment. Open Xcode and start building!")
                ])
            ]
        )
    ]
}
