//
//  BaseModel.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import Foundation
struct BaseModel: Codable {
	let page : PageModel?

	enum CodingKeys: String, CodingKey {

		case page = "page"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(PageModel.self, forKey: .page)
	}

}
