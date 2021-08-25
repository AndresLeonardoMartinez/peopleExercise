//
//  DetailsPresenter.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 14/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation
protocol DetailsPresenterProtocol {

	func numberOfRows() -> Int

	func prepare(_ cell: DetailsTableViewCell, row: Int)

}

class DetailsPresenter: DetailsPresenterProtocol {

	private enum TableSection: Int {
			case name = 0
			case email
			case location
			case total
	}
	private var person: Person?

	init(_ person: Person?) {
		self.person = person
	}

	func numberOfRows() -> Int {
		return TableSection.total.rawValue
	}

	func prepare(_ cell: DetailsTableViewCell, row: Int) {
		guard let index = TableSection(rawValue: row) else {
			return
		}

		switch index {
		case .name:
			let name = person?.name
			cell.configure(icon: "name", text: name ?? "")
		case .email:
			let email = person?.email
			cell.configure(icon: "email", text: email ?? "")
		case .location:
            let location = person?.location
			cell.configure(icon: "location", text: location ?? "")
		default:
			return
		}
	}

}
