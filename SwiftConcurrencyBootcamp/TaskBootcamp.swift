//
//  TaskBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2023/11/23.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            self.image = UIImage(data: data)
        } catch {
            print(#function, error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            self.image2 = UIImage(data: data)
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
    
    var body: some View {
        VStack(spacing: 40, content: {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        })
        .onAppear(perform: {
            // Task同士は同期的に呼び出される
            Task {
                // ThreadとPriorityを確認
                print(Thread.current)
                print(Task.currentPriority.rawValue)
                // Task内は非同期
                await viewModel.fetchImage()
            }
            Task {
                // ThreadとPriorityを確認
                print(Thread.current)
                print(Task.currentPriority.rawValue)
                // Task内は非同期
                await viewModel.fetchImage2()
            }
        })
    }
}

#Preview {
    TaskBootcamp()
}
