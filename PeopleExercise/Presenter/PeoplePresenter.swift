//
//  PeoplePresenter.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation

class PeoplePresenter: PeoplePresenterProtocol {

	private var people: [Person]?
	private var adapter: PeopleAdapterProtocol
	private var view: PeopleViewProtocol

	init(_ adapter: PeopleAdapterProtocol, view: PeopleViewProtocol) {
		self.adapter = adapter
		self.view = view
	}

	func setup() {
		self.view.showLoadingView()
		adapter.getPeople { [weak self] (data) in
			self?.people = data
			self?.view.hideLoadingView()
			self?.view.reloadView()
		}
	}

	func numberOfRows() -> Int {
		return people?.count ?? 0
	}

	func prepare(_ cell: PersonTableViewCell, indexPath: IndexPath) {
		guard let person = people?[indexPath.row] else {
			return
		}
		cell.configure(image: person.picture?.thumbnail,
					   name: "\(person.name?.first ?? "") \(person.name?.last ?? "")",
					   email: person.email ?? "No email",
					   location: "\(person.location?.city ?? ""), \(person.location?.country ?? "")")

	}

	func presentDetails(of row: Int) -> Person? {
		if row <= people?.count ?? 0 {
			return people?[row]
		}
		return nil
	}
}

protocol PeoplePresenterProtocol {

	func setup()
	func numberOfRows() -> Int
	func prepare(_ cell: PersonTableViewCell, indexPath: IndexPath)
	func presentDetails(of row: Int) -> Person?


}
