//
//  Mood.swift
//  MyMood
//
//  Created by Lauro Marinho on 22/04/25.
//

import Foundation

struct Mood: Identifiable, Equatable {
    let id = UUID()
    let emoji: String
    let label: String
}

struct MoodData {
    static let moods: [Mood] = [
        Mood(emoji: "😄", label: "Happy"),
        Mood(emoji: "🙂", label: "Content"),
        Mood(emoji: "😐", label: "Neutral"),
        Mood(emoji: "😔", label: "Sad"),
        Mood(emoji: "😢", label: "Crying"),
        Mood(emoji: "😡", label: "Angry"),
        Mood(emoji: "🥳", label: "Excited"),
        Mood(emoji: "😭", label: "Overwhelmed"),
        Mood(emoji: "😴", label: "Tired"),
        Mood(emoji: "😤", label: "Frustrated"),
        Mood(emoji: "🤯", label: "Stressed"),
        Mood(emoji: "😇", label: "At peace"),
        Mood(emoji: "😎", label: "Confident")
    ]
}
