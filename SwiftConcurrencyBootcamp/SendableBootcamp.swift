//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/11.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDatabase(userInfo: MyUserInfo) {
        print(#function)
    }
}

struct MyUserInfo: Sendable {
    let name: String
}

class SendableBootcampViewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyUserInfo(name: "USER INFO")
        
        await manager.updateDatabase(userInfo: info)
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
