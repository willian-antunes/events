//
//  Coupon.swift
//  Events
//
//  Created by Willian Antunes on 31/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

struct Coupon: Codable, Identifiable {
    
    var id: String
    var eventId: String
    var discount: Int
    
}
