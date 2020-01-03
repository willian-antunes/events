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
    @Published var isLoading = true
    @Published var error = false
    @Published private(set) var errorMessage = ""
    
    func getEvents() {
        
        let successHandler: ([Event]) -> Void = { (response) in
            DispatchQueue.main.async {
                self.events = []
                for data in response {
                    self.events.append(EventViewData.init(event: data))
                }
                self.isLoading = false
            }
        }
        
        let errorHandler: (String) -> Void = { (error) in
            DispatchQueue.main.async {
                self.error = true
                self.errorMessage = error
            }
        }
        
        networkLayer.get(urlString: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events", successHandler: successHandler, errorHandler: errorHandler)
    }
    
}
