//
//  ContentModel.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import Foundation
struct ContentModel : Codable {
	let name : String?
	let posterimage : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case posterimage = "poster-image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		posterimage = try values.decodeIfPresent(String.self, forKey: .posterimage)
	}

}
