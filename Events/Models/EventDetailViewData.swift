//
//  EventDetailViewData.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import Foundation

struct EventDetailViewData {
    
    let networkLayer = Network()
    
    var id: String = defaultText
    var people: [Person] = []
    var date: Int = 0
    var description: String = defaultText
    var image: Data?
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var price: Double = 0
    var title: String = defaultText
    var cupons: [Coupon] = []
    
    init(event: EventDetail) {
        self.id = event.id
        self.people = event.people
        self.date = event.date / 1000
        self.description = event.description
        self.image = nil
        self.coordinates = Coordinates(latitude: event.latitude, longitude: event.longitude)
        self.price = event.price
        self.title = event.title
        self.cupons = event.cupons
    }
    
    init() {
        self.id = defaultText
        self.people = []
        self.date = 0
        self.description = defaultText
        self.coordinates = Coordinates(latitude: 0, longitude: 0)
        self.price = 0
        self.title = defaultText
        self.cupons = []
    }

}
