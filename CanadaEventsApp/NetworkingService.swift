//
//  NetworkingService.swift
//  CanadaEventsApp
//
//  Created by mac on 12/04/2024.
//

import Foundation
import UIKit

protocol networkingDelegate {
    func didFinishGettingList(list: [Event])
    func networkDidFinishWithError();
}

class NetworkingService {
    
    var delegate : networkingDelegate?
    static var shared = NetworkingService()
    
    func getListOfTorontoEvents(_ searchText: String? = nil) {
        var urlString = "https://app.ticketmaster.com/discovery/v2/events.json?city=toronto&countryCode=CA&apikey=mqG7pP3oVIQVWIrA4ZsS0DgbrAstA4Bv"
         
         if let searchText = searchText, !searchText.isEmpty {
             urlString += "&keyword=\(searchText)"
         }
        guard let urlObj = URL(string: urlString) else {
               print("Invalid URL")
               return
           }
        
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            if error != nil {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let jsonString = String(data: data!, encoding: .utf8) {
                print("jsonString")
                    do {
                        var eventList = [Event]() // list to hold the events
                        
                        guard let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                              let embedded = json["_embedded"] as? [String: Any],
                              let events = embedded["events"] as? [[String: Any]] else {
                            print("Invalid JSON format")
                            return
                        }
                        print(events)
                        for eventData in events {
                            // Parse event data
                            let eventName = eventData["name"] as? String ?? ""
                            let eventUrl = eventData["url"] as? String ?? ""
                            
                            if let images = eventData["images"] as? [[String: Any]],
                               let imageUrl = images.first?["url"] as? String {
                                let eventImage = imageUrl
                                
                                // Extracting event date
                                if let dates = eventData["dates"] as? [String: Any],
                                   let start = dates["start"] as? [String: Any],
                                   let localDate = start["localDate"] as? String {
                                    let eventDate = localDate
                                    
                                    // Extracting event venue
                                    if let embedded = eventData["_embedded"] as? [String: Any],
                                       let venues = embedded["venues"] as? [[String: Any]],
                                       let venue = venues.first?["name"] as? String {
                                        let eventVenue = venue
                                        
                                        // Create Event object
                                        let event = Event(eventName: eventName, eventUrl: eventUrl, eventDate: eventDate, eventImageThumb: eventImage, eventVenue: eventVenue)
                                        
                                        // Add event to the list
                                        eventList.append(event)
                                    }
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.delegate?.didFinishGettingList(list: eventList)
                        }
                    } catch {
                        print("Error parsing JSON:", error)
                    }
                    
                }
            }
            task.resume()
        }
    

    
        
}

