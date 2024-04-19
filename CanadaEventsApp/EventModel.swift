//
//  EventModel.swift
//  CanadaEventsApp
//
//  Created by mac on 12/04/2024.
//

import Foundation

class Event  {
    
    var eventName: String = " "
    var eventUrl: String = " "
    var eventDate :String = " "
    var eventImageThumb = " "
//    var eventGenre :String = " "
    var eventVenue :String = " "
    
    init(eventName: String, eventUrl: String, eventDate :String, eventImageThumb:String,  eventVenue :String) {
        self.eventName = eventName
        self.eventUrl = eventUrl
        self.eventImageThumb = eventImageThumb
        self.eventVenue = eventVenue
        
    }
  
}
