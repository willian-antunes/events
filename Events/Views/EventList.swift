//
//  EventList.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI

struct EventList: View {
    
    @ObservedObject var viewModel: EventListViewModel = EventListViewModel()
    
    var body: some View {
        
        VStack {
            if !viewModel.isLoading {
                
                List(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(eventId: event.id)) {
                        EventRow(event: event)
                    }
                }
                
            } else {
                
                ActivityIndicator(isAnimating: $viewModel.isLoading, style: .medium)
                
            }
        }
        .navigationBarTitle("Events")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.viewModel.getEvents()
        }
        .alert(isPresented: $viewModel.error) {
            return Alert(title: Text("Error"), message: Text(LocalizedStringKey(viewModel.errorMessage)))
        }
    }

}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
