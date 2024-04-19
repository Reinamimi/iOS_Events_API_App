//
//  EventDetailViewController.swift
//  CanadaEventsApp
//
//  Created by mac on 18/04/2024.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var selectedIndex: Int = 0
    var selectedEvent: Event?

    @IBOutlet weak var eventTitle: UILabel!
 
    @IBOutlet weak var eventUrlTextview: UITextView!
    
    @IBOutlet weak var eventVenue: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Event Details"
        // Check if selectedEvent is not nil before accessing its properties
             if let event = selectedEvent {
                 eventTitle.text = event.eventName
                 eventVenue.text = event.eventVenue
                 eventDate.text = event.eventDate
                 print(event.eventDate)
                 
                 // Fetch image from URL
                 if let imageUrl = URL(string: event.eventImageThumb) {
                     downloadImage(from: imageUrl)
                 }
                 // Display URL as a clickable link
                 eventUrlTextview.text = event.eventUrl
                eventUrlTextview.isEditable = false
                eventUrlTextview.isSelectable = true
                eventUrlTextview.dataDetectorTypes = .link
                           
                 
            
             } else {
                 print("No event selected")
             }
    }
    
    func downloadImage(from url: URL) {
           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else { return }
               DispatchQueue.main.async() {
                   self.eventImage.image = UIImage(data: data)
               }
           }.resume()
       }
        
    

    @IBAction func addToList(_ sender: Any) {
        
        guard let event = selectedEvent else {
                   return // Exit if there's no selected event
               }
               
               FavoritesManager.shared.addFavorite(event: event)
        
        // Show alert
              let alertController = UIAlertController(title: "Success", message: "Event added to favorites!", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alertController.addAction(okAction)
              present(alertController, animated: true, completion: nil)
               
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
