//
//  AffirmationPool.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

struct AffirmationPool {
    private static let pool: [Emotion: [String]] = [
        .anger: [
            "The fire in you is power. Now let it rest.",
            "Your anger was heard. It doesn't have to stay.",
            "That heat meant something. You can release it now.",
            "Fire that burns also warms. You are still whole.",
            "You felt it fully. That's enough. Let it go.",
            "Rage is just love with nowhere to land. Breathe.",
            "You are allowed to be angry. And to move forward."
        ],
        .overwhelmed: [
            "You don't have to carry it all at once.",
            "One thing. Just one thing for right now.",
            "It's okay that it felt like too much. It was.",
            "You made it this far. That already took strength.",
            "Rest is not giving up. Rest is how you continue.",
            "You are more than what you didn't finish today.",
            "Being overwhelmed means you care deeply. That matters.",
            "The weight was real. And now it belongs to the sky."
        ],
        .anxiety: [
            "Your mind is loud. You are still safe.",
            "Uncertainty is not the same as danger.",
            "You've survived every storm before this one.",
            "The chaos in your head doesn't define what's real.",
            "Breathe first. The rest can wait a moment.",
            "You are calmer than you think you are right now.",
            "Not everything needs to be figured out today."
        ]
    ]
    
    static func random(for emotion: Emotion) -> String {
        let affirmations = pool[emotion] ?? pool[.anxiety]! // Fallback ke anxiety jika unknown
        return affirmations.randomElement() ?? "Breathe. Let it go."
    }
}
