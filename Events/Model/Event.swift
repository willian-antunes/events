//
//  EventModel.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

struct Event: Codable {
    
    var id: String
    var title: String
    var date: Int
    var price: Double
    
}
