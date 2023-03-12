//
//  AddNewNoteView.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 27.01.2023.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @ObservedObject var notes: Notes
    @State private var name = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    private var isSave: Bool {
        if name.isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader { geo in
            Form {
                Section("Введите название") {
                     TextField("", text: $name)
                }
                Section("Введите содержимое") {
                    TextEditor(text: $description)
                        .frame(height: geo.size.height * 0.7)
                }
            }
        }
        .navigationTitle("Новая заметка")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") {
                let item = Note(name: name, description: description, date: Date.now)
                if !notes.datesStorage.contains(item.formattedDate) {
                    notes.datesStorage.insert(item.formattedDate, at: 0)
                }
                notes.notesStorage.insert(item, at: 0)
                dismiss()
            }
            .disabled(isSave)
        }
    }
}







struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView(notes: Notes())
    }
}
