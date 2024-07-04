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
            
            await MainActor.run {
                self.image = UIImage(data: data)
            }
        } catch {
            print(#function, error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
        } catch {
            print(#function, error.localizedDescription)
        }
    }
    
    // fetchImage()に5秒遅延を入れただけ
    func fetchImageWithSleep() async {
        do {
            // 5sec delay
            try await Task.sleep(nanoseconds: 5_000_000_000)
            
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            await MainActor.run {
                self.image = UIImage(data: data)
                print("--- Image returned successfully ---")
            }
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationStack {
            ZStack(content: {
                NavigationLink("CLICK ME! 😎😎😎") {
                    TaskBootcamp()
                }
            })
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
            /*
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
             */
            /*
             Task(priority: .low) {
             print("low :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             Task(priority: .medium) {
             print("medium :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             Task(priority: .high) {
             print("high :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             Task(priority: .background) {
             print("background :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             Task(priority: .utility) {
             print("utility :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             Task(priority: .userInitiated) {
             print("userInitiated :\n \(Task.currentPriority.rawValue) : \(Thread.current)")
             }
             */
            /*
            Task(priority: .low) {
                print("low : \(Thread.current) : \(Task.currentPriority.rawValue)")
                
                Task.detached {
                    print("detached : \(Thread.current) : \(Task.currentPriority.rawValue)")
                }
            }
            */
            
            Task {
                await viewModel.fetchImageWithSleep()
            }
        })
    }
}

#Preview {
    TaskBootcamp()
}
