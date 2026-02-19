import UIKit
import CoreHaptics

final class HapticManager {
    static let shared = HapticManager()

    private var engine: CHHapticEngine?

    private init() {
        prepareHaptics()
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            engine?.resetHandler = { [weak self] in
                do {
                    try self?.engine?.start()
                } catch {
                    print("Failed to restart haptic engine: \(error)")
                }
            }
        } catch {
            print("Haptic engine error: \(error)")
        }
    }

    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    func complexPattern() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = engine else { return }

        var events: [CHHapticEvent] = []

        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let event1 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event1)

        let intensity2 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)
        let sharpness2 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event2 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity2, sharpness2], relativeTime: 0.1)
        events.append(event2)

        let intensity3 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness3 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
        let event3 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity3, sharpness3], relativeTime: 0.2)
        events.append(event3)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error)")
        }
    }
}
