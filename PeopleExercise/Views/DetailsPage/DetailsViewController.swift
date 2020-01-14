//
//  DetailsViewController.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 12/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

	@IBOutlet var table: UITableView!
	var person: Person?
	private var presenter: DetailsPresenterProtocol?

	private let avatar: CustomImageView = {
		let avatar = CustomImageView()
		avatar.translatesAutoresizingMaskIntoConstraints = false
		avatar.layer.cornerRadius = 20
		avatar.clipsToBounds = true
		return avatar
	}()

	override func viewDidLoad() {
        super.viewDidLoad()
		presenter = DetailsPresenterFactory(person: person).presenter
		title = "Details"
		prepareTable()
		setupConstraints()
		loadTableHeaderImage()
    }

	func prepareTable() {
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(UINib(nibName: DetailsTableViewCell.id, bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.id)
		table.tableHeaderView = avatar
		table.dataSource = self
		table.separatorStyle = .none
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			avatar.topAnchor.constraint(equalTo: table.topAnchor, constant: 14),
			avatar.widthAnchor.constraint(equalToConstant: view.frame.width * 0.3),
			avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
			avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		avatar.layoutIfNeeded()
	}

	func loadTableHeaderImage() {
		avatar.loadImageUsingCache(urlString: person?.picture?.large ?? "") { (_) in }
	}


}

extension DetailsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.numberOfRows() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.id, for: indexPath)
			as? DetailsTableViewCell else {
			return UITableViewCell()
		}
		presenter?.prepare(cell, row: indexPath.row)
		return cell
	}

}


