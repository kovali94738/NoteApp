//
//  DateList.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 29.01.2023.
//

import Foundation
import SwiftUI

struct DateList: View {
    @ObservedObject var notes: Notes
    var body: some View {
        List {
            //Grouping by sections
            ForEach(notes.datesStorage.filter({ filterOut($0) }), id: \.self) { date in
                Section(date) {
                    //Adding suitable dates to the section
                    ForEach(notes.notesStorage.filter({$0.formattedDate == date})) { note in
                            NavigationLink {
                                EditNoteView(notes: notes, savedNote: note)
                            } label: {
                                HStack {
                                    Text(note.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(note.date, format: .dateTime.hour().minute())
                                        .font(.subheadline)
                                        .opacity(0.5)
                                }
                            }
                        }
                    .onDelete(perform: notes.removeItem)
                    .onMove(perform: notes.moveItem)
                }
            }
        }
    }
    
    //filters out dates for which there are no notes
    func filterOut(_ date: String) -> Bool {
        for i in notes.notesStorage {
            if i.formattedDate == date {
                return true
            }
        }
        return false
    }
    
}
