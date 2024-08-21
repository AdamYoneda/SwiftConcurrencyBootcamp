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

@MainActor
final class MVVMBootcampViewModel: ObservableObject {
    
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    @Published private(set) var myData: String = "Starting Text"
    private var tasks: [Task<Void, Never>] = []
    
    func onCallToActionButtonPressed() {
        let task = Task {
            do {
                //                myData = try await managerClass.getData()
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

struct MVVMBootcamp: View {
    
    @StateObject private var viewModel = MVVMBootcampViewModel()
    
    var body: some View {
        VStack(content: {
            Button(viewModel.myData) {
                viewModel.onCallToActionButtonPressed()
            }
        })
        .onDisappear(perform: {
            viewModel.cancelTasks()
        })
    }
}

#Preview {
    MVVMBootcamp()
}
