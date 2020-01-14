//
//  DetailsTableViewCell.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 14/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
	static let id = "DetailsTableViewCell"

	@IBOutlet var label: UILabel!
	@IBOutlet var icon: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.contentView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configure(icon: String, text: String, isBold: Bool = false) {
		label.text = text
		self.icon.image = UIImage(named: icon)
		
	}
    
}
