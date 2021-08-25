//
//  PeoplePresenterFactory.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 14/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation
class PeoplePresenterFactory {

	let presenter: PeoplePresenterProtocol

	init(_ view: PeopleViewProtocol) {
		let adapter = PeopleAdapter()
		presenter = PeoplePresenter(adapter, view: view)
	}
}
