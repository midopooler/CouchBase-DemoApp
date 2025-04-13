//
//  Note.swift
//  CouchbaseNotes
//
//  Created by Pulkit Midha on 13/04/25.
//

import Foundation

struct Note: Identifiable, Hashable {
    let id: String
    var title: String
    var content: String

    init(id: String = UUID().uuidString, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
