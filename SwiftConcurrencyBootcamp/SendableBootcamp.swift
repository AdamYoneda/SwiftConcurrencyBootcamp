//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/11.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDatabase() {
        
    }
}

class SendableBootcampViewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        await manager.updateDatabase()
    }
}

struct SendableBootcamp: View {
    
    @State private var viewModel = SendableBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.updateCurrentUserInfo()
            }
    }
}

#Preview {
    SendableBootcamp()
}
