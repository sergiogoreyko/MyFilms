//
//  ContentView.swift
//  MyFilms
//
//  Created by Сергей Горейко on 21.05.2021.
//

import SwiftUI

struct FilmsList: View {
    
    @ObservedObject var filmListVM = FilmListViewModel()
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    if presentAddNewItem {
                        FilmCell(
                            filmCellVM: FilmCellViewModel(
                                film: Film(title: "",
                                           isWatched: false)
                            )
                        ) { film in
                            self.filmListVM.addFilm(film: film)
                            self.presentAddNewItem.toggle()
                        }
                    }
                    
                    ForEach(filmListVM.filmCellViewModels) { filmCellVM in
                        FilmCell(filmCellVM: filmCellVM)
                    }
                }
                
                Button(action: { self.presentAddNewItem.toggle()}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                
                        Text("Добавить фильм")
                    }
                    .foregroundColor(.red)
                }
                .padding()
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarTitle("Мои фильмы")
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct FilmsList_Previews: PreviewProvider {
    static var previews: some View {
        FilmsList()
    }
}
