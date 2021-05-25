//
//  FilmCell.swift
//  MyFilms
//
//  Created by Сергей Горейко on 21.05.2021.
//

import SwiftUI

struct FilmCell: View {
    
    @ObservedObject var filmCellVM: FilmCellViewModel
    
    var onCommit: (Film) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: filmCellVM.film.isWatched ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.filmCellVM.film.isWatched.toggle()
                }
            
            TextField("Enter new fim", text: $filmCellVM.film.title) { isBegin in
                if !isBegin {
                    self.onCommit(self.filmCellVM.film)
                }
            }

        }
    }
}



