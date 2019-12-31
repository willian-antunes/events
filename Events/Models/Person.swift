//
//  Person.swift
//  Events
//
//  Created by Willian Antunes on 31/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

struct Person: Codable, Identifiable {
    
    var id: String
    var eventId: String
    var name: String
    var picture: String
    
}
