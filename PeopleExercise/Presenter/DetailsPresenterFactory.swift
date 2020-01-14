//
//  DetailsPresenterFactory.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 14/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation
class DetailsPresenterFactory {

	let presenter: DetailsPresenterProtocol

	init(person: Person?) {
		presenter = DetailsPresenter(person)
	}
}
