//
//  MVVMBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/08/21.
//

import SwiftUI

final class MyManagerClass {
    func getData() async throws -> String {
        return "Some Data!"
    }
}

actor MyManagerActor {
    func getData() async throws -> String {
        return "Some Data!"
    }
}

final class MVVMBootcampViewModel: ObservableObject {
    
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    func onCallToActionButtonPressed() {
        Task {
            
        }
    }
}

struct MVVMBootcamp: View {
    
    @StateObject private var viewModel = MVVMBootcampViewModel()
    
    var body: some View {
        Button("Click me!") {
            viewModel.onCallToActionButtonPressed()
        }
    }
}

#Preview {
    MVVMBootcamp()
}
