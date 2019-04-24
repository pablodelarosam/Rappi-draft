//
//  Media.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/20/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

class Media:  Codable {
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var id: Int?
    var genre_ids: [Int]?
    var title: String?
    var original_title: String?
    var release_date: String?
    
    init(raw: AnyObject) {
        poster_path = raw.value(forKey: "poster_path") as? String
        id = raw.value(forKey: "id") as? Int
        title = raw.value(forKey: "title") as? String
    }
}