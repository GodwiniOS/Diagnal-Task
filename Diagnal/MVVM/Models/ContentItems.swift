//
//  ContentItems.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import Foundation
struct ContentItems : Codable {
	let content : [ContentModel]?

	enum CodingKeys: String, CodingKey {

		case content = "content"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		content = try values.decodeIfPresent([ContentModel].self, forKey: .content)
	}

}
