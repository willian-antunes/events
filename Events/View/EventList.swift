//
//  EventList.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI

struct EventList: View {
    
    @ObservedObject var viewModel: EventViewModel = EventViewModel()
    
    var body: some View {

        List(viewModel.events) { event in
            EventRow(event: event)
        }
        .navigationBarTitle("Events")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.getEvents()
        }
    }
    
    private func getEvents() {
        viewModel.getEvents()
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}