//
//  EventDetailViewModel.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI
import Combine

class EventDetailViewModel: ObservableObject {
    
    let networkLayer = Network()
    
    @Published private(set) var event = EventDetailViewData()
    @Published private(set) var isLoading = true
    @Published private(set) var isPosting = true
    @Published var showShareSheet = false
    @Published var error = false
    @Published private(set) var errorMessage = ""
    
    func getEvent(id: String) {
        
        let successHandler: (EventDetail) -> Void = { (response) in
            DispatchQueue.main.async {
                self.isLoading = false
                self.event = EventDetailViewData(event: response)
                self.getImage(url: response.image)
            }
        }
        
        let errorHandler: (String) -> Void = { (error) in
            DispatchQueue.main.async {
                self.error = true
                self.errorMessage = error
            }
        }
        
        networkLayer.get(urlString: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events/\(id)", successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func getImage(url: String) {
        
        let successHandler: (Data) -> Void = { (response) in
            DispatchQueue.main.async {
                self.event.image = response
            }
        }
        
        let errorHandler: (String) -> Void = { (error) in
            print(error)
        }
        
        networkLayer.get(urlString: url, successHandler: successHandler, errorHandler: errorHandler)
        
    }
    
    func getFormattedDate() -> String {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(event.date)))
        
    }
    
    func postCheckIn(id: String) {
        
        let errorHandler: (String) -> Void = { (error) in
            DispatchQueue.main.async {
                self.error = true
                self.errorMessage = error
            }
        }
        
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        
        networkLayer.post(urlString: "https://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin", body: CheckIn(eventId: id, name: name, email: email), errorHandler: errorHandler)
        
    }
    
}


