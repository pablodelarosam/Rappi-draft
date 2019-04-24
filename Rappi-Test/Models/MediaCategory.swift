//
//  MediaCategory.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/21/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

struct MediaCategory: Decodable {
    
    let name: String?
    var mediaFiles: [Media]?
    var type: String?
}
