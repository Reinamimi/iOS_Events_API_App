//
//  FavoritesTableViewCell.swift
//  CanadaEventsApp
//
//  Created by mac on 18/04/2024.
//

import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: FavoritesTableViewCell)
}

class FavoritesTableViewCell: UITableViewCell {
    
    weak var delegate: FavoritesTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var urlTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        
        delegate?.didTapDeleteButton(in: self)
    }
    
    
    
}
