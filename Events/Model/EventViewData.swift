//
//  EventViewData.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

let defaultText: String = "N/A"
struct EventViewData: Hashable, Identifiable {
    
    var id: String = defaultText
    var title: String = defaultText
    var date: Int = 0
    var price: Double = 0
    
    init(event: Event) {
        self.id = event.id
        self.title = event.title
        self.date = event.date / 1000
        self.price = event.price
    }

}
