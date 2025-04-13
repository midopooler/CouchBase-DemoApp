//
//  NotesListView.swift
//  CouchbaseNotes
//
//  Created by Pulkit Midha on 13/04/25.
//

import SwiftUI

struct NotesListView: View {
    @State private var notes: [Note] = CouchbaseManager.shared.fetchNotes()
    @State private var showEditor = false
    @State private var selectedNote: Note? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(notes, id: \.id) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.content)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectedNote = note
                        showEditor = true
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Couchbase Notes")
            .toolbar {
                Button(action: {
                    selectedNote = nil
                    showEditor = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showEditor, onDismiss: {
                loadNotes()
            }) {
                NoteEditorView(note: selectedNote)
            }
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            CouchbaseManager.shared.deleteNote(note)
        }
        loadNotes()
    }

    func loadNotes() {
        notes = CouchbaseManager.shared.fetchNotes()
    }
}
