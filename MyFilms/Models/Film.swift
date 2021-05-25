//
//  Film.swift
//  MyFilms
//
//  Created by Сергей Горейко on 21.05.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Film: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isWatched: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userID: String?
}

