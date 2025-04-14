# Couchbase Notes

A lightweight, native iOS notes application built with SwiftUI and Couchbase Lite. Create, edit, and manage your notes with local persistence.

## Features

- Create and edit notes with title and content
- View all notes in a clean, modern interface
- Delete unwanted notes
- Local data persistence using Couchbase Lite
- Native SwiftUI interface

## Tech Stack

- Swift
- SwiftUI
- Couchbase Lite Swift
- iOS 15.0+
- Xcode 14.0+

## Getting Started

### Prerequisites

- Xcode 14.0 or later
- iOS 15.0+ deployment target
- Swift Package Manager

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/CouchbaseNotes.git
```

2. Add Couchbase Lite Swift dependency through Swift Package Manager:
   - In Xcode, go to File > Add Packages
   - Enter the package URL: `https://github.com/couchbase/couchbase-lite-ios.git`
   - Select the version you want to use
   - Click Add Package

3. Build and run the project in Xcode

## Project Structure

```
CouchbaseNotes/
├── CouchbaseNotesApp.swift    # App entry point
├── Models/
│   └── Note.swift            # Note data model
├── Views/
│   ├── NotesListView.swift   # Main notes list view
│   └── NoteEditorView.swift  # Note creation/editing view
├── Managers/
│   └── CouchbaseManager.swift # Database operations handler
```

### Core Components

#### CouchbaseManager
- Singleton class managing all database operations
- Handles CRUD operations for notes
- Initializes and manages Couchbase Lite database

#### Note Model
```swift
struct Note: Identifiable, Hashable {
    let id: String
    var title: String
    var content: String
}
```

#### Views
- NotesListView: Displays all notes in a list format with delete capability
- NoteEditorView: Form for creating and editing notes

## Usage

1. Launch the app
2. Tap the '+' button to create a new note
3. Enter title and content for your note
4. Tap 'Save' to store the note
5. View all notes in the main list
6. Tap any note to edit
7. Swipe left on a note to delete

## Future Improvements

- [ ] Search functionality
- [ ] Note categories/tags
- [ ] Rich text support
- [ ] Cloud sync
- [ ] User-facing error handling
- [ ] Note sorting options
- [ ] Dark mode support

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Screenshots

<p align="center">
<img src="Snapshots/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-04-14%20at%2011.48.55.png" width="200" style="margin-right: 10px"/>
<img src="Snapshots/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-04-14%20at%2011.49.17.png" width="200" style="margin-right: 10px"/>
<img src="Snapshots/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-04-14%20at%2011.49.25.png" width="200" style="margin-right: 10px"/>


## Acknowledgments

- [Couchbase Lite](https://docs.couchbase.com/couchbase-lite/current/swift/quickstart.html)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
