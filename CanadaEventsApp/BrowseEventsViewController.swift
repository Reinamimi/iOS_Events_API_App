//
//  BrowseEventsViewController.swift
//  CanadaEventsApp
//
//  Created by mac on 18/04/2024.
//

import UIKit

class BrowseEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, networkingDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Toronto Events"
        searchBar.delegate = self
        NetworkingService.shared.delegate = self
        NetworkingService.shared.getListOfTorontoEvents()
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appDelegate?.eventlist.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let event = appDelegate?.eventlist[indexPath.row]
            cell.textLabel?.text = event?.eventName
        cell.detailTextLabel?.text = event?.eventDate
        
        return cell
    }
    
    func networkDidFinishWithError() {
        return
    }
    
    func didFinishGettingList(list: [Event]) {
        appDelegate?.eventlist = list
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 2 {
            NetworkingService.shared.getListOfTorontoEvents(searchText)
            
        }

            
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetail" {
            let detailVC = segue.destination as? EventDetailViewController
            
            let indext = tableView.indexPathForSelectedRow!.row

            detailVC?.selectedEvent = (appDelegate?.eventlist[indext])!
            detailVC?.selectedIndex = indext
            
        }
        
    }
}
