//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/07/23.
//

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: {
                self.runTest()
            })
    }
}

#Preview {
    StructClassActorBootcamp()
}

extension StructClassActorBootcamp {
    
    private func runTest() {
        print("--- Test Started ---")
    }
}
