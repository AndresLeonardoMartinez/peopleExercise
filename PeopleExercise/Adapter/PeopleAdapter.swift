//
//  PeopleAdapter.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation
import Combine

protocol PeopleAdapterProtocol {

	func getPeople(completionHandler: @escaping (_ people: [Person]?) -> Void)
    
    func getPeople() -> AnyPublisher<People, NetworkError>
}

class PeopleAdapter: PeopleAdapterProtocol {

	let networkingManager: Networkable

	init(networkingManager: Networkable) {
		self.networkingManager = networkingManager
	}

	func getPeople(completionHandler: @escaping (_ people: [Person]?) -> Void) {
		let amount = 30
		var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=\(amount)")!)
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")


		self.networkingManager.get(request, completionHandler: {(data: People?) -> Void in
			completionHandler(data?.results)}

		)
	}
    
    func getPeople() -> AnyPublisher<People, NetworkError> {
        let amount = 30
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=\(amount)")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return networkingManager.get(request)
    }

}
