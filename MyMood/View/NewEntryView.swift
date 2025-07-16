//
//  NewEntryView.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//


import SwiftUI

struct NewEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: JournalViewModel

    @State private var title = ""
    @State private var text = ""
    @State private var selectedMood = ""

    let moods = MoodData.moods

    var emojiScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(moods) { mood in
                    Button(action: {
                        selectedMood = mood.emoji
                    }) {
                        Text(mood.emoji)
                            .font(.largeTitle)
                            .padding(8)
                            .background(selectedMood == mood.emoji ? Color.purple.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("How do you feel?", text: $title)
                    }

                    Section(header: Text("How are you feeling?")) {
                        emojiScrollView
                    }

                    Section(header: Text("Notes")) {
                        TextEditor(text: $text)
                            .frame(height: 100)
                    }
                }

                Button("Save") {
                    viewModel.addEntry(title: title, text: text, mood: selectedMood)
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
