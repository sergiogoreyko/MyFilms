//
//  FilmCellViewModel.swift
//  MyFilms
//
//  Created by Сергей Горейко on 22.05.2021.
//

import Foundation
import Combine


class FilmCellViewModel: ObservableObject, Identifiable {
    
    @Published var filmRepository = FilmRepository()
    @Published var film: Film
    
    var id = ""
    @Published var isWatchedStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(film: Film) {
        self.film = film
        
        $film
            .map { film in
                film.isWatched ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.isWatchedStateIconName, on: self)
            .store(in: &cancellables)
        
        $film
            .compactMap { film in
                film.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $film
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { film in
                self.filmRepository.updateFilm(film)
            }
            .store(in: &cancellables)
    }
}
