//
//  Int+HTTPStatusCode.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/20/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
