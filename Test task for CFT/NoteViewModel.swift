//
//  NoteViewModel.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 27.01.2023.
//

import Foundation

class Notes: ObservableObject {
    
    @Published var notesStorage = [Note(name: "What is it here?", description: "Oh so it's my birthday...", date: exampleDate)] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(notesStorage) {
                UserDefaults.standard.set(encodedData, forKey: "Notes")
            }
        }
    }
    
    static var exampleDate: Date {
        var components = DateComponents()
        components.day = 5
        components.month = 3
        components.year = 2002
        components.hour = 4
        let date = Calendar.current.date(from: components) ?? Date.now
        return date
    }
    
    //dates for displaying sections of the interface
    @Published var datesStorage = [formattedExampleDate] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(datesStorage) {
                UserDefaults.standard.set(encodedData, forKey: "Dates")
            }
        }
    }
   
    static var formattedExampleDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: exampleDate)
    }
    
    
    init() {
        guard
            let dataNotes = UserDefaults.standard.data(forKey: "Notes"),
            let savedNotes = try? JSONDecoder().decode([Note].self, from: dataNotes)
        else { return }
        
        self.notesStorage = savedNotes
        
        guard
            let dataDates = UserDefaults.standard.data(forKey: "Dates"),
            let savedDates = try? JSONDecoder().decode([String].self, from: dataDates)
        else { return }
        
        self.datesStorage = savedDates
    }
    
    
    func removeItem(at offsets: IndexSet) {
        notesStorage.remove(atOffsets: offsets)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        notesStorage.move(fromOffsets: from, toOffset: to)
    }
    
    func editItem(id: UUID, name: String, description: String, date: Date) {
        if let note = notesStorage.first(where: { $0.id == id }) {
            let index = notesStorage.firstIndex(of: note)
            notesStorage[index!].name = name
            notesStorage[index!].description = description
            notesStorage[index!].date = date
        }
    }
    
}
