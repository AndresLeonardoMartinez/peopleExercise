//
//  NetworkingManager.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation
import Combine

protocol Networkable {

	/// Make a GET to an API
	/// - Parameter request: The request to be fetched
	/// - Parameter completionHandler: When the GET is successful and the data could be decoded, return a
	/// entity. Otherwise return nil. NOTE: Entity must be a Codable object
	func get<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (_ entity: T?) -> Void)
    
    // get using publisher
    func get<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError>

}

public class NetworkingManager: Networkable {

	func get<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (_ entity: T?) -> Void) {
		let session = URLSession.shared
		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			print(response!)
			do {
				let decoder = JSONDecoder()
				guard let data = data else {
					completionHandler(nil)
					return
				}
				let dataDecoded = try decoder.decode(T.self, from: data)
				completionHandler(dataDecoded)
			} catch let jsonError {
					print(jsonError)
				}
		})
		task.resume()
	}
    
    func get<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                guard let httpURLResponse = response.response as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200 else {
                    throw NetworkError.statusCode
                }
                return response.data
            }
            .decode(type: T.self, decoder:  JSONDecoder())
            .mapError({ error in
                NetworkError.other(error)
            })
            .eraseToAnyPublisher()
    }

}

enum NetworkError: Error {
    case statusCode
    case decoding
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> NetworkError {
        return (error as? NetworkError) ?? .other(error)
    }
}
