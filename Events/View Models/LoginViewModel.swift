//
//  LoginViewModel.swift
//  Events
//
//  Created by Willian Antunes on 29/12/19.
//  Copyright © 2019 Willian Antunes. All rights reserved.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var goToEventList: Int? = 0
    
    func performLogin() {
        UserDefaults.standard.set(self.name, forKey: "name")
        UserDefaults.standard.set(self.email, forKey: "email")
        UserDefaults.standard.set(self.password, forKey: "password")
        goToEventList = 1
    }
    
    var allFilled: Bool {
        return !self.name.isEmpty && !self.password.isEmpty && !self.email.isEmpty
    }
    
    var buttonColor: Color {
        return allFilled ? Color.pink : Color.pink.opacity(0.5)
    }
    
}
