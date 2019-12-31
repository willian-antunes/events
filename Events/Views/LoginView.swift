//
//  ContentView.swift
//  Events
//
//  Created by Willian Antunes on 28/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    init() {
        
        UINavigationBar.appearance().tintColor = .systemPink
        
    }
    
    var body: some View {

        NavigationView {
            VStack(alignment: .center, spacing: 16) {
                
                Image("events")
                    .foregroundColor(.pink)
                    .padding(.bottom, 16)
                
                TextField("Name", text: $viewModel.name)
                    .padding(.horizontal, 24)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)
                
                TextField("E-mail", text: $viewModel.email)
                    .padding(.horizontal, 24)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .padding(.horizontal, 24)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button(action: {
                    
                    self.viewModel.performLogin()
                    
                }) {
                    
                    Text("Login")
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 64)
                        .background(self.viewModel.buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                }
                .disabled(!viewModel.allFilled)
                
                NavigationLink(destination: EventList(), tag: 1, selection: $viewModel.goToEventList) {
                    EmptyView()
                }
                
                Spacer()
                
            }
            
        }
            
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
