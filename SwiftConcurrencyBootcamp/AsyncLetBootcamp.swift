//
//  AsyncLetBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/07/05.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/1000")!
    
    var body: some View {
        NavigationView(content: {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Async Let 🥳")
            .onAppear(perform: {
                /*
                Task {
                    do {
                        // fetchImageを複数回呼び出す
                        let image_1 = try await fetchImage()
                        self.images.append(image_1)
                        let image_2 = try await fetchImage()
                        self.images.append(image_2)
                        let image_3 = try await fetchImage()
                        self.images.append(image_3)
                        let image_4 = try await fetchImage()
                        self.images.append(image_4)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                */
                
            })
        })
    }
    
    func fetchImage() async throws -> UIImage {
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

#Preview {
    AsyncLetBootcamp()
}
