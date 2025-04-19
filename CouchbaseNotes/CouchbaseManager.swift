//
//  CouchbaseManager.swift
//  CouchbaseNotes
//
//  Created by Pulkit Midha on 13/04/25.
//

import CouchbaseLiteSwift

class CouchbaseManager {
    static let shared = CouchbaseManager()
    private let database: Database
    private var replicator: Replicator?
    
    // MARK: - Configuration
    private let syncGatewayUrl = URL(string: "")! // Changed from couchbases:// to wss://
    private let username = "mido"
    private let password = ""
    private let dbName = "mido"
    
    private init() {
        do {
            database = try Database(name: dbName)
        } catch {
            fatalError("Error initializing database: \(error)")
        }
        setupReplication()
    }
    
    // MARK: - Replication Setup
    private func setupReplication() {
        // Configure replicator target
        let target = URLEndpoint(url: syncGatewayUrl)
        
        // Configure replicator
        var config = ReplicatorConfiguration(database: database, target: target)
        config.continuous = true  // Enable continuous replication
        
        // Set up authentication
        config.authenticator = BasicAuthenticator(username: username, password: password)
        
        // Create replicator
        replicator = Replicator(config: config)
        
        // Add replication status listener with more detailed logging
        replicator?.addChangeListener { (change) in
            if let error = change.status.error {
                print("❌ Sync error: \(error)")
            }
            print("📡 Sync status: \(change.status.activity)")
            print("📊 Documents pushed: \(change.status.progress.completed)")
            print("🔄 Documents pending: \(change.status.progress.total - change.status.progress.completed)")
        }
        
        // Start replication
        replicator?.start()
    }
    
    // MARK: - Database Operations
    func save(note: Note) {
        let doc = MutableDocument(id: note.id)
        doc.setString(note.title, forKey: "title")
        doc.setString(note.content, forKey: "content")

        do {
            try database.saveDocument(doc)
        } catch {
            print("❌ Failed to save document: \(error)")
        }
    }

    func fetchNotes() -> [Note] {
        var results: [Note] = []

        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id),
                    SelectResult.property("title"),
                    SelectResult.property("content"))
            .from(DataSource.database(database))

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
            if let document = try? database.document(withID: note.id) {
                try database.deleteDocument(document)
                print("Deleted note with ID: \(note.id)")
            } else {
                print("Document not found with ID: \(note.id)")
            }
        } catch {
            print("Error deleting document: \(error)")
        }
    }
    
    // MARK: - Sync Management
    func startSync() {
        replicator?.start()
    }
    
    func stopSync() {
        replicator?.stop()
    }
    
    func getSyncStatus() -> Replicator.ActivityLevel? {
        return replicator?.status.activity
    }
}
