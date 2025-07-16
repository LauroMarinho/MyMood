//
//  EntryDetailView.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//

import SwiftUI

struct EntryDetailView: View {
    var entry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(entry.title ?? "")
                    .font(.largeTitle).bold()
                HStack {
                    Text(entry.mood ?? "")
                    Text(entry.date ?? Date(), style: .date)
                        .foregroundColor(.gray)
                }
                Text(entry.text ?? "")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Entry")
    }
}




