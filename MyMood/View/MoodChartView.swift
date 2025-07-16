//
//  MoodChartView.swift
//  MyMood
//
//  Created by Lauro Marinho on 22/04/25.
//

import SwiftUI
import Charts
import CoreData

struct MoodCount: Identifiable {
    let id = UUID()
    let mood: String
    let count: Int
    let percentage: Double
}

struct MoodChartView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.date, ascending: true)],
        animation: .default
    ) private var entries: FetchedResults<JournalEntry>

    var moodCounts: [MoodCount] {
        let moodFrequency = Dictionary(grouping: entries) { $0.mood ?? "❓" }
            .mapValues { $0.count }

        let total = moodFrequency.values.reduce(0, +)

        return moodFrequency.map { mood, count in
            MoodCount(mood: mood, count: count, percentage: Double(count) / Double(total))
        }
        .sorted { $0.count > $1.count }
    }

    func barColor(for percentage: Double) -> Color {
        let base = Color.purple
        let opacity = 0.4 + percentage * 0.6
        return base.opacity(opacity)
    }

    func labelForMood(_ emoji: String) -> String {
        return MoodData.moods.first(where: { $0.emoji == emoji })?.label ?? "Outro"
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Mood Statistics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            if moodCounts.isEmpty {
                Text("No mood data available.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart(moodCounts) { moodData in
                    BarMark(
                        x: .value("Count", moodData.count),
                        y: .value("Mood", "\(moodData.mood) \(labelForMood(moodData.mood))")
                    )
                    .foregroundStyle(barColor(for: moodData.percentage))
                    .annotation(position: .trailing) {
                        HStack(spacing: 4) {
                            Text("\(Int(moodData.percentage * 100))%")
                                .font(.caption)
                                .bold()
                            Text("\(moodData.count)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisTick().foregroundStyle(.clear)
                        AxisGridLine().foregroundStyle(.clear)
                        AxisValueLabel()
                    }
                }
                .frame(height: CGFloat(60 * moodCounts.count))
            }

            Spacer()
        }
        .padding()
    }
}
