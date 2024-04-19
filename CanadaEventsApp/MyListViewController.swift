//
//  MyListViewController.swift
//  CanadaEventsApp
//
//  Created by mac on 18/04/2024.
//

import UIKit

class MyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesTableViewCellDelegate {
    
    var favoritesList: [Event]?
 
    @IBOutlet weak var favoritesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My List"
        favoritesList = FavoritesManager.shared.getFavorites()
        favoritesTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList!.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoritesTableViewCell
        
            cell.delegate = self
        cell.titleLabel.text = favoritesList![indexPath.row].eventName
        
//        for displaying the event url
        let displayText = "visit event Website"
        let urlString = favoritesList![indexPath.row].eventUrl
        // Create an attributed string with a link attribute
                let attributedString = NSMutableAttributedString(string: displayText)
                let range = NSRange(location: 0, length: displayText.count)
                attributedString.addAttribute(.link, value: urlString, range: range)
        cell.urlTextView.attributedText = attributedString
        cell.urlTextView.isEditable = false
        cell.urlTextView.dataDetectorTypes = .link
        cell.urlTextView.isUserInteractionEnabled = true
        

            return cell
    }
    
    func didTapDeleteButton(in cell: FavoritesTableViewCell) {
        if let indexPath = favoritesTable.indexPath(for: cell) {
            if let eventToRemove = favoritesList?[indexPath.row] {
                        FavoritesManager.shared.removeFavorite(event: eventToRemove)
                        favoritesList?.remove(at: indexPath.row)
                        favoritesTable.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
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
