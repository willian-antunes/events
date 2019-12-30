//
//  EventViewModel.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI
import Combine

class EventListViewModel: ObservableObject {
    
    let networkLayer = Network()
    
    @Published private(set) var events = [EventViewData]()
    @Published private(set) var isLoading = true
    
    func getEvents() {
        
        let successHandler: ([Event]) -> Void = { (response) in
            DispatchQueue.main.async {
                self.events = []
                for data in response {
                    self.isLoading = false
                    self.events.append(EventViewData.init(event: data))
                }
            }
        }
        
        let errorHandler: (String) -> Void = { (error) in
            print(error)
        }
        
        networkLayer.get(urlString: "https://5b840ba5db24a100142dcd8c.mockapi.io/api/events", successHandler: successHandler, errorHandler: errorHandler)
    }
    
}