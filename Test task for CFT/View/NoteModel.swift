//
//  NoteModel.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 27.01.2023.
//

import Foundation

struct Note: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var date: Date
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }
}
