//
//  EditNoteView.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 27.01.2023.
//

import SwiftUI

struct EditNoteView: View {
    
    @ObservedObject var notes: Notes
    @State var savedNote: Note
    @Environment(\.dismiss) var dismiss
    
    private var isSave: Bool {
        if savedNote.name.isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader { geo in
            Form {
                Section("Введите название") {
                    TextField("", text: $savedNote.name)
                }
                Section("Введите содержимое") {
                    TextEditor(text: $savedNote.description)
                        .frame(height: geo.size.height * 0.7)
                }
            }
        }
        .navigationTitle("Редактирование заметки")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") {
                notes.editItem(id: savedNote.id, name: savedNote.name, description: savedNote.description, date: savedNote.date)
                dismiss()
            }
            .disabled(isSave)
        }
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(notes: Notes(), savedNote: Note(name: "Check", description: "...", date: Date.now))
    }
}
