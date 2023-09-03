//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2023/09/04.
//

import SwiftUI

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive: Bool = false
    
    func getTitle() -> (title:String?, error: Error?) {
        if isActive {
            return ("New Text!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text2!")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
        /*
        let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            text = newTitle
        } else if let error = returnedValue.error {
            text = error.localizedDescription
        }
         */
        
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            text = newTitle
        case .failure(let error):
            text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsBootcamp()
    }
}
