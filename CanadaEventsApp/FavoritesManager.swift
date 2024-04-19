//
//  FavoritesManager.swift
//  CanadaEventsApp
//
//  Created by mac on 18/04/2024.
//

import Foundation
import UIKit

class FavoritesManager {
    static let shared = FavoritesManager()
    
//    
//    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var favoritesList = [Event]()
    
    
    
    private init() {}
    
    func addFavorite(event: Event) {
        
       favoritesList.append(event)
    }
    
    func removeFavorite(event: Event) {
        if let index = favoritesList.firstIndex(where: { $0.eventName == event.eventName }) {
            favoritesList.remove(at: index)
        }
    }
    
    func getFavorites() -> [Event] {
        return favoritesList
    }
}
