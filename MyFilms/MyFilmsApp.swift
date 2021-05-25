//
//  MyFilmsApp.swift
//  MyFilms
//
//  Created by Сергей Горейко on 21.05.2021.
//

import SwiftUI
import Firebase

@main
struct MyFilmsApp: App {
    
    init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
    }
    
    var body: some Scene {
        WindowGroup {
            FilmsList()
        }
    }
}
