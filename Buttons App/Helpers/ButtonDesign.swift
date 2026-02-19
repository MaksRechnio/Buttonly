import SwiftUI

struct ButtonDesign: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let subtitle: String
    let icon: String
    let primaryColor: Color
    let secondaryColor: Color

    static func == (lhs: ButtonDesign, rhs: ButtonDesign) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static let allDesigns: [ButtonDesign] = [
        ButtonDesign(id: 0, name: "Neon Glow", subtitle: "Cyberpunk pulsating border", icon: "bolt.fill",
                     primaryColor: Color(red: 0, green: 1, blue: 0.8), secondaryColor: Color(red: 0.5, green: 0, blue: 1)),
        ButtonDesign(id: 1, name: "Neumorphic", subtitle: "Soft UI tactile press", icon: "circle.inset.filled",
                     primaryColor: Color(red: 0.22, green: 0.24, blue: 0.29), secondaryColor: Color(red: 0.16, green: 0.18, blue: 0.22)),
        ButtonDesign(id: 2, name: "Glassmorphic", subtitle: "Frosted glass transparency", icon: "rectangle.on.rectangle",
                     primaryColor: Color(red: 0.4, green: 0.6, blue: 1), secondaryColor: Color(red: 0.8, green: 0.4, blue: 1)),
        ButtonDesign(id: 3, name: "Liquid Morph", subtitle: "Organic blob animation", icon: "drop.fill",
                     primaryColor: Color(red: 1, green: 0.4, blue: 0.6), secondaryColor: Color(red: 1, green: 0.6, blue: 0.2)),
        ButtonDesign(id: 4, name: "3D Push", subtitle: "Duolingo-style depth press", icon: "cube.fill",
                     primaryColor: Color(red: 0.3, green: 0.85, blue: 0.4), secondaryColor: Color(red: 0.2, green: 0.65, blue: 0.3)),
        ButtonDesign(id: 5, name: "Gradient Wave", subtitle: "Animated flowing gradient", icon: "water.waves",
                     primaryColor: Color(red: 1, green: 0.5, blue: 0), secondaryColor: Color(red: 1, green: 0, blue: 0.5)),
        ButtonDesign(id: 6, name: "Magnetic Pull", subtitle: "Cursor-attracted motion", icon: "magnet.fill",
                     primaryColor: Color(red: 0.9, green: 0.2, blue: 0.3), secondaryColor: Color(red: 1, green: 0.4, blue: 0.1)),
        ButtonDesign(id: 7, name: "Elastic Jelly", subtitle: "Bouncy squish effect", icon: "waveform",
                     primaryColor: Color(red: 0.6, green: 0.3, blue: 1), secondaryColor: Color(red: 0.9, green: 0.3, blue: 0.8)),
        ButtonDesign(id: 8, name: "Particle Burst", subtitle: "Explosive particle shower", icon: "sparkles",
                     primaryColor: Color(red: 1, green: 0.8, blue: 0), secondaryColor: Color(red: 1, green: 0.4, blue: 0)),
        ButtonDesign(id: 9, name: "Ripple Effect", subtitle: "Material Design water ripple", icon: "circle.hexagongrid.fill",
                     primaryColor: Color(red: 0.2, green: 0.6, blue: 1), secondaryColor: Color(red: 0.1, green: 0.4, blue: 0.9)),
        ButtonDesign(id: 10, name: "Aurora Borealis", subtitle: "Northern lights shimmer", icon: "sun.max.trianglebadge.exclamationmark",
                     primaryColor: Color(red: 0, green: 0.9, blue: 0.6), secondaryColor: Color(red: 0.3, green: 0.2, blue: 0.9)),
        ButtonDesign(id: 11, name: "Cyber Glitch", subtitle: "Digital distortion flicker", icon: "tv.fill",
                     primaryColor: Color(red: 1, green: 0, blue: 0.4), secondaryColor: Color(red: 0, green: 1, blue: 1)),
        ButtonDesign(id: 12, name: "Pulse Ring", subtitle: "Expanding ring sonar", icon: "dot.radiowaves.right",
                     primaryColor: Color(red: 0.3, green: 0.8, blue: 1), secondaryColor: Color(red: 0.1, green: 0.5, blue: 0.9)),
        ButtonDesign(id: 13, name: "Shimmer Shine", subtitle: "Metallic light sweep", icon: "light.max",
                     primaryColor: Color(red: 0.85, green: 0.75, blue: 0.55), secondaryColor: Color(red: 0.95, green: 0.9, blue: 0.7)),
        ButtonDesign(id: 14, name: "Morph Icon", subtitle: "Shape-shifting symbol", icon: "star.fill",
                     primaryColor: Color(red: 0.9, green: 0.3, blue: 0.5), secondaryColor: Color(red: 0.5, green: 0.3, blue: 0.9)),
        ButtonDesign(id: 15, name: "Retro Pixel", subtitle: "8-bit arcade nostalgia", icon: "gamecontroller.fill",
                     primaryColor: Color(red: 0.2, green: 0.8, blue: 0.2), secondaryColor: Color(red: 0.1, green: 0.5, blue: 0.1)),
        ButtonDesign(id: 16, name: "Holographic", subtitle: "Rainbow foil iridescence", icon: "rainbow",
                     primaryColor: Color(red: 0.8, green: 0.5, blue: 1), secondaryColor: Color(red: 0.3, green: 0.8, blue: 1)),
        ButtonDesign(id: 17, name: "Typewriter", subtitle: "Mechanical key clack", icon: "keyboard.fill",
                     primaryColor: Color(red: 0.95, green: 0.9, blue: 0.8), secondaryColor: Color(red: 0.6, green: 0.5, blue: 0.4)),
        ButtonDesign(id: 18, name: "Circuit Board", subtitle: "Tech pathway animation", icon: "cpu.fill",
                     primaryColor: Color(red: 0, green: 1, blue: 0.5), secondaryColor: Color(red: 0, green: 0.6, blue: 0.3)),
        ButtonDesign(id: 19, name: "Gravity Float", subtitle: "Zero-G levitation bob", icon: "arrow.up.and.down.circle.fill",
                     primaryColor: Color(red: 0.5, green: 0.7, blue: 1), secondaryColor: Color(red: 0.3, green: 0.4, blue: 0.9))
    ]
}
