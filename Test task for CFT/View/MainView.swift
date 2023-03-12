//
//  ContentView.swift
//  Test task for CFT
//
//  Created by Григорий Ковалев on 27.01.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var notes = Notes()
    @State private var isShowInfo = false
    let infoText = "Для того чтобы сохранить заметку необходимо дать ей название и нажать \"Save\".\n Чтобы сохранить изменения в редактируемой заметке нужно нажать \"Save\"."
    
    var body: some View {
        NavigationStack {
            DateList(notes: notes)
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    isShowInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .padding(.top)
                }
                Spacer()
            }
            .background(.thinMaterial)
            
            .navigationTitle("Notes app")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewNoteView(notes: notes)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            
        }
        .preferredColorScheme(.dark)
        .alert("Info", isPresented: $isShowInfo) {
            Button("OK", role: .cancel) {  }
        } message: {
            Text(infoText)
        }

    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
