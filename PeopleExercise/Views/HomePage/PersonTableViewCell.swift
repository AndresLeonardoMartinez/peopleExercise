//
//  PersonTableViewCell.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
	static let id = "PersonTableViewCell"

	@IBOutlet weak var avatarImageView: CustomImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var location: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		avatarImageView.layer.cornerRadius = 10
    }

	func configure(image: String?, name: String, email: String, location: String) {
		if let image = image {
			self.avatarImageView.loadImageUsingCache(urlString: image) { (_) in }
		}
		self.name.text = name
		self.email.text = email
		self.location.text = location
	}

}
