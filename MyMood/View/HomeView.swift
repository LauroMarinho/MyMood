//
//  HomeView.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = JournalViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var showingNewEntry = false
    @State private var selectedMoodFilter: String? = nil

    let moods = MoodData.moods

    var filteredEntries: [JournalEntry] {
        if let filter = selectedMoodFilter {
            return viewModel.entries.filter { $0.mood == filter }
        } else {
            return viewModel.entries
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("My Diary")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: MoodChartView()) {
                        Image(systemName: "chart.pie.fill")
                            .imageScale(.large)
                            .font(.title2)
                            .foregroundColor(.purple)
                            .padding(.trailing, 8)
                    }
                    Button(action: { showingNewEntry = true }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            selectedMoodFilter = nil
                        }) {
                            Text("All")
                                .padding(8)
                                .background(selectedMoodFilter == nil ? Color.purple.opacity(0.2) : Color.clear)
                                .cornerRadius(8)
                                .foregroundColor(selectedMoodFilter == nil ? Color.primary : Color.primary.opacity(0.8))
                        }

                        ForEach(moods) { mood in
                            Button(action: {
                                selectedMoodFilter = mood.emoji
                            }) {
                                Text(mood.emoji)
                                    .font(.largeTitle)
                                    .padding(8)
                                    .background(selectedMoodFilter == mood.emoji ? Color.purple.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                List {
                    ForEach(filteredEntries, id: \.id) { entry in
                        NavigationLink(destination: EntryDetailView(entry: entry)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(entry.title ?? "")
                                        .font(.headline)
                                    Spacer()
                                    Text(entry.mood ?? "")
                                }
                                Text(entry.date ?? Date(), style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { filteredEntries[$0] }.forEach(viewModel.delete)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top)
            .sheet(isPresented: $showingNewEntry) {
                NewEntryView(viewModel: viewModel)
            }
        }
    }
}

