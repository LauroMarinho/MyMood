//
//  JournalViewModel.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//

import Foundation
import CoreData

class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []

    let viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchEntries()
    }

    func fetchEntries() {
        let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \JournalEntry.date, ascending: false)]

        do {
            entries = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch entries: \(error)")
        }
    }

    func addEntry(title: String, text: String, mood: String) {
        let newEntry = JournalEntry(context: viewContext)
        newEntry.id = UUID()
        newEntry.title = title
        newEntry.text = text
        newEntry.mood = mood
        newEntry.date = Date()

        do {
            try viewContext.save()
            fetchEntries()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
        }
    }

    func delete(_ entry: JournalEntry) {
        viewContext.delete(entry)
        do {
            try viewContext.save()
            fetchEntries()
        } catch {
            print("Failed to delete entry: \(error.localizedDescription)")
        }
    }
}
