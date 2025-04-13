//
//  NoteEditorView.swift
//  CouchbaseNotes
//
//  Created by Pulkit Midha on 13/04/25.
//

import SwiftUI

struct NoteEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var content: String
    private var noteId: String

    init(note: Note?) {
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
        noteId = note?.id ?? UUID().uuidString
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("Note")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let note = Note(id: noteId, title: title, content: content)
                        CouchbaseManager.shared.save(note: note)
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
