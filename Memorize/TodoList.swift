//
//  TodoList.swift
//  Memorize
//
//  Created by Eric Li on 2020/6/13.
//  Copyright © 2020 Eric Li. All rights reserved.
//

import SwiftUI

var exampleTodos: [Todo] = [
    Todo(title: "golang", dueDate: Date()),
    Todo(title: "php", dueDate: Date()),
    Todo(title: "java", dueDate: Date()),
    Todo(title: "scala", dueDate: Date()),
    Todo(title: "swift", dueDate: Date()),
    Todo(title: "python", dueDate: Date())
    
]

struct TodoList: View {
    @ObservedObject var main: Main
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(main.todos){ todo in
                    VStack{
                        if todo.i == 0 || formatter.string(from: todo.dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate){
                            HStack{
                                Spacer().frame(width:30)
                                Text(date2Word(date: todo.dueDate))
                                Spacer()
                            }
                        }
                        HStack{
                            Spacer().frame(width:20)
                            TodoItem(main: self.main, todoIndex: .constant(todo.i))
                                .cornerRadius(10)
                                .clipped()
                                .shadow(color: Color("todoItemShadow"), radius: 5)
                            Spacer()
                        }
                        Spacer().frame(height:20)
                    }
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("TodoList"))
            .onAppear{
                if let data = UserDefaults.standard.object(forKey: "todos") as? Data{
                    
                    do{
                        let todolist = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Todo] ?? []
                        for todo in todolist{
                            if !todo.checked{
                                self.main.todos.append(todo)
                            }
                        }
                    }catch{
                        print("error")
                    }
                    
                }else{
                    self.main.todos = exampleTodos
                    self.main.sort()
                }
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main: Main())
    }
}
