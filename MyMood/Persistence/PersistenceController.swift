//
//  PersistenceController.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyMood")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
        }
    }
}

extension PersistenceController {
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Exemplo de dado fictício para o preview
        let sampleEntry = JournalEntry(context: viewContext)
        sampleEntry.id = UUID()
        sampleEntry.title = "Preview Title"
        sampleEntry.text = "This is a preview entry used in SwiftUI preview."
        sampleEntry.date = Date()
        sampleEntry.mood = "🙂"

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved preview error: \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()
}

