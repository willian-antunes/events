//
//  EventDetail.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI
import Combine

struct EventDetailView: View {
    
    @ObservedObject var viewModel: EventDetailViewModel = EventDetailViewModel()
    @State var eventId: String
    
    var body: some View {
        
        VStack() {
            
            MapView(coordinate: viewModel.event.coordinates)
                .edgesIgnoringSafeArea(.top)
                .frame(height: UIScreen.main.bounds.height / 3)
            
            CircleImage(image: imageFromData(imageData: viewModel.event.image))
                .offset(x: 0, y: -122)
                .padding(.bottom, -122)
            
            HStack(alignment: .bottom) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("$\(String(format: "%.2f", viewModel.event.price))")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.pink)
                
                    Text(self.viewModel.getFormattedDate())
                        .font(.system(size: 20, weight: .regular, design: .default))
                    
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 16) {
                    
                    Button(action: {
                        
                        self.viewModel.showShareSheet = true
                        
                    }) {
                        
                        Image(systemName: "square.and.arrow.up.fill")
                            .foregroundColor(.pink)
                            .font(.largeTitle)
                    
                    }
                    
                    Button(action: {
                        
                        self.viewModel.postCheckIn(id: self.eventId)
                        
                    }) {
                        
                        Text("Check-in")
                            .bold()
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            
                    }
                }
                .sheet(isPresented: $viewModel.showShareSheet) {
                    ShareSheet(activityItems: ["\(self.viewModel.event.title) \(self.viewModel.getFormattedDate())"])
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.top, -48)
            
            Divider()
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Text(viewModel.event.description)
                    
                    Divider()
                    
                    Text("Going")
                        .font(.headline)

                    HStack() {
                        
                        ForEach(self.viewModel.event.people) { person in
                            VStack(alignment: .center) {
                                
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                
                                Text(person.name)
                                
                            }
                        }
                        
                    }
                    
                    Divider()
                    
                    Text("Coupons")
                        .font(.headline)
                    
                    HStack() {
                        
                        ForEach(self.viewModel.event.cupons) { coupon in
                            VStack(alignment: .center) {
                                
                                Image(systemName: "tag.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                
                                Text("\(coupon.discount)%")
                                
                            }
                        }
                        
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width - 32)

            }
            
        }
        .onAppear {
            self.viewModel.getEvent(id: self.eventId)
        }
        .alert(isPresented: $viewModel.error) {
            return Alert(title: Text("Error"), message: Text(LocalizedStringKey(viewModel.errorMessage)))
        }
        .navigationBarTitle(Text(viewModel.event.title), displayMode: .inline)
    }
    
    private func imageFromData(imageData: Data?) -> Image {
        guard let data = imageData else {
            return Image(systemName: "camera.circle.fill")
        }
        
        guard let uiImage = UIImage(data: data) else {
            return Image(systemName: "camera.circle.fill")
        }
        
        return Image(uiImage: uiImage)
    }

}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(eventId: "3")
    }
}
