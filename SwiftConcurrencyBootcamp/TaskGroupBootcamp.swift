//
//  TaskGroupBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/07/09.
//

import SwiftUI

class TaskGroupBootcampDataManager {
    
    private let urlString = "https://picsum.photos/1000"
    
    // 画像〜5枚程度までならasync letで全然対応できる
    /// async letを用いて、各タスクを並行に実行する
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage(urlString: urlString)
        async let fetchImage2 = fetchImage(urlString: urlString)
        async let fetchImage3 = fetchImage(urlString: urlString)
        async let fetchImage4 = fetchImage(urlString: urlString)
        
        let images = await [try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4]
        return images
    }
    
    // 画像〜5枚程度までならasync letで全然対応できたが、~20枚、~50枚となると対応が難しくなる
    // そこでTask Groupを利用する
    /// Task Groupを用いて、各タスクを並行に実行する
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        // fetchに使用するURL(試しに5個)
        let imageUrlStrings = [urlString, urlString, urlString, urlString, urlString]
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(imageUrlStrings.count)
            // タスクの追加
            for imageUrlString in imageUrlStrings {
                group.addTask {
                    return try await self.fetchImage(urlString: imageUrlString)
                }
            }
            
            for try await image in group {
                images.append(image)
            }
            
            return images
        }
    }
    
    // AsyncLetBootcamp.swiftから引用
    // DataManager内でのみ呼ぶようにprivate化
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupBootcampViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootcampDataManager() // 後でDIする
    
    func getImages() async {
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}

struct TaskGroupBootcamp: View {
    
    @StateObject private var viewModel = TaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView(content: {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Task Group 🙄")
            .task {
                await viewModel.getImages()
            }
        })
    }
}

#Preview {
    TaskGroupBootcamp()
}
