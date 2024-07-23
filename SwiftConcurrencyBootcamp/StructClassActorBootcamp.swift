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

struct MyStruct {
    var title: String
}

extension StructClassActorBootcamp {
    
    private func runTest() {
        print("//* Test Started *//")
        structTest1()
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: \(objectA.title)")
        
        var objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        // titleを変更
        objectB.title = "Second title!!"
        print("---- ObjectB title Changed ---")
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
    }
}
