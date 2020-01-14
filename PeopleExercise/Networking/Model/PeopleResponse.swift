
//
//  PeopleResponse.swift
//  PeopleExercise
//
//  Created by Andres Leonardo Martinez on 10/01/2020.
//  Copyright © 2020 Andres Leonardo Martinez. All rights reserved.
//

import Foundation

// MARK: - People
class People: Codable {
	var results: [Person]?

	init(results: [Person]?) {
		self.results = results
	}
}

// MARK: - Person
class Person: Codable {
	var gender: String?
	var name: Name?
	var location: Location?
	var email: String?
//	var login: Login?
//	var dob, registered: Dob?
//	var phone: String?
	var cell: String?
//	var id: ID?
	var picture: Picture?
//	var nat: String?

	init(gender: String?,
		 name: Name?,
		 location: Location?,
		 email: String?,
//		 login: Login?,
//		 dob: Dob?,
//		 registered: Dob?,
//		 phone: String?,
		 cell: String?,
//		 id: ID?,
		 picture: Picture?
		/* nat: String?*/) {
		self.gender = gender
		self.name = name
		self.location = location
		self.email = email
//		self.login = login
//		self.dob = dob
//		self.registered = registered
//		self.phone = phone
		self.cell = cell
//		self.id = id
		self.picture = picture
//		self.nat = nat
	}
}

// MARK: - Dob
class Dob: Codable {
	var date: String?
	var age: Int?

	init(date: String?, age: Int?) {
		self.date = date
		self.age = age
	}
}

// MARK: - ID
class ID: Codable {
	var name: String?
	var value: String?

	init(name: String?, value: String?) {
		self.name = name
		self.value = value
	}
}

// MARK: - Location
class Location: Codable {
	var street: Street?
	var city, state, country: String?
	var postcode: Postcode?
	var coordinates: Coordinates?
	var timezone: Timezone?

	init(street: Street?,
		 city: String?,
		 state: String?,
		 country: String?,
		 postcode: Postcode?,
		 coordinates: Coordinates?,
		 timezone: Timezone?) {
		self.street = street
		self.city = city
		self.state = state
		self.country = country
		self.postcode = postcode
		self.coordinates = coordinates
		self.timezone = timezone
	}
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Coordinates
class Coordinates: Codable {
	var latitude, longitude: String?

	init(latitude: String?, longitude: String?) {
		self.latitude = latitude
		self.longitude = longitude
	}
}

// MARK: - Street
class Street: Codable {
	var number: Int?
	var name: String?

	init(number: Int?, name: String?) {
		self.number = number
		self.name = name
	}
}

// MARK: - Timezone
class Timezone: Codable {
	var offset, timezoneDescription: String?

	enum CodingKeys: String, CodingKey {
		case offset
		case timezoneDescription = "description"
	}

	init(offset: String?, timezoneDescription: String?) {
		self.offset = offset
		self.timezoneDescription = timezoneDescription
	}
}

// MARK: - Login
class Login: Codable {
	var uuid, username, password, salt: String?
	var md5, sha1, sha256: String?

	init(uuid: String?,
		 username: String?,
		 password: String?,
		 salt: String?,
		 md5: String?,
		 sha1: String?,
		 sha256: String?) {
		self.uuid = uuid
		self.username = username
		self.password = password
		self.salt = salt
		self.md5 = md5
		self.sha1 = sha1
		self.sha256 = sha256
	}
}

// MARK: - Name
class Name: Codable {
	var title, first, last: String?

	init(title: String?, first: String?, last: String?) {
		self.title = title
		self.first = first
		self.last = last
	}
}

// MARK: - Picture
class Picture: Codable {
	var large, medium, thumbnail: String?

	init(large: String?, medium: String?, thumbnail: String?) {
		self.large = large
		self.medium = medium
		self.thumbnail = thumbnail
	}
}
