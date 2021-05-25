//
//  FilmRepository.swift
//  MyFilms
//
//  Created by Сергей Горейко on 25.05.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FilmRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var films = [Film]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let currentUserId = Auth.auth().currentUser?.uid
            
        db.collection("films")
            .order(by: "createdTime", descending: true)
            .whereField("userID", isEqualTo: currentUserId)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.films = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Film.self)
                }
            }
        }
    }
    
    func addFilm(_ film: Film) {
        do {
            var addedFilm = film
            addedFilm.userID = Auth.auth().currentUser?.uid
            let _ = try db.collection("films").addDocument(from: addedFilm)
        } catch {
            fatalError("Unable to decode film: \(error.localizedDescription)")
        }
    }
    
    func updateFilm(_ film: Film) {
        if let filmID = film.id {
            do {
                try db.collection("films").document(filmID).setData(from: film)
            } catch  {
                fatalError("Unable to encode film: \(error.localizedDescription)")
            }
        }
    }
}
