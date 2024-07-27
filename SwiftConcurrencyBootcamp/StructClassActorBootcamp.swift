//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Adam Yoneda on 2024/07/23.
//

/*
 
 REF Links:
 https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbTFMOUFtY2tRcmNTNUFsc1Y5Q013Ti0zOFRhd3xBQ3Jtc0tsN3FWNVhlRzRyR2RKcGNMRkx1cE5vTFNabVVwUXZQRGRtNkxMdGxEMmxxTFR3V05HbEl0eG1rRUdyS3dLRGowak9RYTRmUkVPT2ZaVkVZUVpzY2lIWEp0VHl5X0NsdlNkclkzeTBEN3k2VTdoMDZRcw&q=https%3A%2F%2Fblog.onewayfirst.com%2Fios%2Fposts%2F2019-03-19-class-vs-struct%2F&v=-JLenSTKEcA
 https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqazNDVUl0RFFPYU4zQWpqenl2T0JGZXNFcGVLQXxBQ3Jtc0ttQUxNYzdtUWxyREtlallVb3RJTS1lUUd2TlpVMjZxcC1BdFNtc2FBbEtNZUdueXJ6UzBTSElzWEplRUNpOHFqS2MtbFZibVEwUFVwZ2luQWZ5VkxQWDFMTjgyOEVJQjQweU5BelNqZlNJNUZYWk9IRQ&q=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F24217586%2Fstructure-vs-class-in-swift-language&v=-JLenSTKEcA
 https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbkppbGNycGpKc1VlRjk5aDZNNnh3SS1yeGNSd3xBQ3Jtc0trWldzMVpKSFNoWEI2bkV4TEcySTU3ZWpJYlFmRGU4a2JWbmVQdHlnaVBZNGI2TERrYXdLLTB4eTJqWVNzYkh2Ml9ob1ZhX1hDUW5zNkZ4YlhxclRRd2ZkS0xNNlYxbkxCTlFmZ3Z0TWsxX01QZWZFMA&q=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F24217586%2Fstructure-vs-class-in-swift-language%2F59219141%2359219141&v=-JLenSTKEcA
 https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbmM5T3hWMF9JZnZNVEUxSl9LMTIzVGVyMjcwZ3xBQ3Jtc0ttV19JV3JRRDljOEJEV1ZjLTFoNVNtdDlDY2ZBamFLNnF0TVVZX29wbkZBQzAtYjhRU2t1SDFfMVM1Ml9lQVV2Y1htUkdPTmpOcEREY2ttYWxnMGc3UkpsNXUxY1N2OW9TTDhiLXpaQ2twMEV0Q3ZLaw&q=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F27441456%2Fswift-stack-and-heap-understanding&v=-JLenSTKEcA
 https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99
 
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack Memory
 - Faster
 - Thread Safe: 各ThreadにStackが存在している
 - 値渡し: When you assign or pass value type a new copy of data is created.
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap Memory
 - Slower, but synchronized
 - NOT Thread Safe(by default)
 - When you assign or pass reference type a new reference to original instance will be created(the address of instance is copied).
 
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
 STACK:
 - Stores Value types
 - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast.
 - Each Thread has it's own stack
 
 HEAP:
 - Stores Reference types
 - Shared across threads(スレッド間で共有)
 
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
 STRUCT:
 - Based on Values
 - Can be mutated
 - Stored in the Stack
 
 CLASS:
 - Based on References(instanceとも呼ばれる)
 - Stored in the Heap
 - Inherit from other classes
 
 ACTOR:
 - Same as Class, but thread safe
 
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
 
 */



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
        print("//* Test Started *//")
        //        structTest1()
        classTest1()
        //        structTest2()
        //        classTest2()
        print("================================")
        actorTest1()
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

// MARK: - Struct
// プロパティを変数で定義
struct MyStruct {
    var title: String
}

// プロパティを定数で定義
// Immutable struct
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        return CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String // (set)をつけるとprivateな値も取得できる
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        self.title = newTitle
    }
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
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: \(struct3.title)")
        struct3 = struct3.updateTitle(newTitle: "Title2") // ここで上書き
        print("Struct3: \(struct3.title)")
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: \(struct4.title)")
        struct4.updateTitle(newTitle: "Title2") // ここで上書き
        print("Struct4: \(struct4.title)")
    }
}

// MARK: - Class vs Actor
class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func classTest1() {
        print(#function)
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
    
    
    
    private func actorTest1() {
        print(#function)
        // Task{}でasync環境に
        Task {
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: \(objectA.title)")
            
            let objectB = objectA
            await print("ObjectB: \(objectB.title)")
            
            // titleを変更
            await objectB.updateTitle(newTitle: "Second title!!")
            print("---- ObjectB title Changed ---")
            
            await print("ObjectA: \(objectA.title)")
            await print("ObjectB: \(objectB.title)")
        }
    }
    
    private func classTest2() {
        print(#function)
        
        let class1 = MyClass(title: "Title1")
        print("Class1: \(class1.title)")
        class1.title = "Title2"
        print("Class1: \(class1.title)")
        
        let class2 = MyClass(title: "Title1")
        print("Class1: \(class2.title)")
        class2.updateTitle(newTitle: "Title2")
        print("Class1: \(class2.title)")
    }
}
