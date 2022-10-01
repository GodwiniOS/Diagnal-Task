//
//  PageModel.swift
//  Diagnal
//
//  Created by Godwin A on 30/09/22.
//

import Foundation

struct PageModel : Codable {
	let title : String?
	let totalcontentitems : String?
	let pagenum : String?
	let pagesize : String?
	let contentitems : ContentItems?

	enum CodingKeys: String, CodingKey {

        case title = "title"
        case totalcontentitems = "total-content-items"
        case pagenum = "page-num"
        case pagesize = "page-size"
        case contentitems = "content-items"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		totalcontentitems = try values.decodeIfPresent(String.self, forKey: .totalcontentitems)
		pagenum = try values.decodeIfPresent(String.self, forKey: .pagenum)
		pagesize = try values.decodeIfPresent(String.self, forKey: .pagesize)
		contentitems = try values.decodeIfPresent(ContentItems.self, forKey: .contentitems)
	}

}
