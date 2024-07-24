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

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

extension StructClassActorBootcamp {
    
    private func runTest() {
        print("//* Test Started *//")
        //        structTest1()
        //        classTest1()
        structTest2()
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
    
    private func classTest1() {
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: \(objectA.title)")
        
        let objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        // titleを変更
        objectB.title = "Second title!!"
        print("---- ObjectB title Changed ---")
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
    }
}

// プロパティを変数で定義
struct MyStruct {
    var title: String
}

// プロパティを定数で定義
// Immutable struct
struct CustomStruct {
    let title: String
}

extension StructClassActorBootcamp {
    
    private func structTest2() {
        print(#function)
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: \(struct1.title)")
        struct1.title = "Title2"
        print("Struct1: \(struct1.title)")
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: \(struct2.title)")
        struct2 = CustomStruct(title: "Title2") // ここで上書き
        print("Struct2: \(struct2.title)")
    }
}
