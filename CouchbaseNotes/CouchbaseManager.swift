//
//  CouchbaseManager.swift
//  CouchbaseNotes
//
//  Created by Pulkit Midha on 13/04/25.
//

import CouchbaseLiteSwift

class CouchbaseManager {
    static let shared = CouchbaseManager()

    private let dbName = "notesdb"
    private(set) var database: Database?

    private init() {
        do {
            database = try Database(name: dbName)
        } catch {
            print("❌ Failed to open database: \(error)")
        }
    }

    func save(note: Note) {
        guard let db = database else { return }
        let doc = MutableDocument(id: note.id)
        doc.setString(note.title, forKey: "title")
        doc.setString(note.content, forKey: "content")

        do {
            try db.saveDocument(doc)
        } catch {
            print("❌ Failed to save document: \(error)")
        }
    }
    func fetchNotes() -> [Note] {
        guard let db = database else { return [] }
        var results: [Note] = []

        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id),
                    SelectResult.property("title"),
                    SelectResult.property("content"))
            .from(DataSource.database(db))

        do {
            for row in try query.execute() {
                let id = row.string(forKey: "id") ?? UUID().uuidString
                let title = row.string(forKey: "title") ?? ""
                let content = row.string(forKey: "content") ?? ""
                results.append(Note(id: id, title: title, content: content))
            }
        } catch {
            print("❌ Failed to fetch documents: \(error)")
        }

        return results
    }

    func deleteNote(_ note: Note) {
        do {
            if let document = database?.document(withID: note.id) {
                try database?.deleteDocument(document)
                print("Deleted note with ID: \(note.id)")
            } else {
                print("Document not found with ID: \(note.id)")
            }
        } catch {
            print("Error deleting document: \(error)")
        }
    }
}
