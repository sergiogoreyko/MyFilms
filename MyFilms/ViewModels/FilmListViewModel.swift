//
//  FilmListViewModel.swift
//  MyFilms
//
//  Created by Сергей Горейко on 22.05.2021.
//

import Foundation
import Combine


class FilmListViewModel: ObservableObject {
    
    @Published var filmRepository = FilmRepository()
    @Published var filmCellViewModels = [FilmCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        filmRepository.$films
            .map { films in
                films.map { film in
                    FilmCellViewModel(film: film)
                }
            }
            .assign(to: \.filmCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addFilm(film: Film) {
        filmRepository.addFilm(film)
    }
}
