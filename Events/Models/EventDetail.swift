//
//  EventDetail.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

struct EventDetail: Codable {
    
    var id: String
    var people: [Person]
    var date: Int
    var description: String
    var image: String
    var longitude: Double
    var latitude: Double
    var price: Double
    var title: String
    var cupons: [Coupon]
    
}
