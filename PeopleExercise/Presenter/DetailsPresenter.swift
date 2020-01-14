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
			case gender
			case cellphone
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
			let name = "\(person?.name?.first ?? "") \(person?.name?.last ?? "")"
			cell.configure(icon: "name", text: name)
		case .email:
			let email = person?.email ?? "No email"
			cell.configure(icon: "email", text: email)
		case .location:
			let location = "\(person?.location?.city ?? ""), \(person?.location?.country ?? "")"
			cell.configure(icon: "location", text: location)
		case .gender:
			let gender = "\(person?.gender ?? "")"
			cell.configure(icon: "gender", text: gender)
		case .cellphone:
			let cellphone = "\(person?.cell ?? "")"
			cell.configure(icon: "cellphone", text: cellphone)
		default:
			return
		}
	}

}
