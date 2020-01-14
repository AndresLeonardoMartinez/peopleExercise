//
//  PeopleTableViewController.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import UIKit

protocol PeopleViewProtocol {

	func reloadView()

	func hideLoadingView()

	func showLoadingView()

}
class PeopleTableViewController: UITableViewController {

	private var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
		activityIndicator.contentMode = .scaleAspectFill
		return activityIndicator
	}()

	private var presenter: PeoplePresenterProtocol!

	override func viewDidLoad() {
        super.viewDidLoad()
		title = "People"
		view.backgroundColor = .white
		tableView.register(UINib(nibName: PersonTableViewCell.id, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.id)
		presenter = PeoplePresenterFactory(self).presenter
		presenter.setup()
		view.addSubview(activityIndicator)
		setupConstraintToActivityIndicator()
    }

	private func setupConstraintToActivityIndicator() {
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.id, for: indexPath)
			as? PersonTableViewCell else {
			return UITableViewCell()
		}
		presenter.prepare(cell, indexPath: indexPath)
        return cell
    }

	override func tableView(_ tableView: UITableView,
				   didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showDetails", sender: self)

	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? DetailsViewController,
			let indexPath = tableView?.indexPathForSelectedRow {
			destination.person = presenter.presentDetails(of: indexPath.row)
		}
	}
}

extension PeopleTableViewController: PeopleViewProtocol {

	func hideLoadingView() {
		DispatchQueue.main.async {
			self.activityIndicator.isHidden = true
		}
	}

	func showLoadingView() {
		DispatchQueue.main.async {
			self.activityIndicator.isHidden = false
		}
	}


	func reloadView() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}

	}

}
