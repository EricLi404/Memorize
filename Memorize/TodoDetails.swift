//
//  TodoDetails.swift
//  Memorize
//
//  Created by Eric Li on 2020/6/13.
//  Copyright © 2020 Eric Li. All rights reserved.
//

import SwiftUI

struct TodoDetails: View {
    @ObservedObject var main: Main
    var body: some View {
        VStack{
            Spacer().frame(height:50)
            HStack{
                Button(action: {
                    UIApplication.shared.keyWindow?.endEditing(true)
                    self.main.detailsShowing = false
                }){
                    Text("Cancel").padding()
                }
                Spacer()
                Button(action: {
                    UIApplication.shared.keyWindow?.endEditing(true)
                    if editingMode{
                        self.main.todos[editingIndex].title = self.main.detailsTitle
                        self.main.todos[editingIndex].dueDate = self.main.detailsDueDate
                    }else{
                        let newTodo = Todo(title: self.main.detailsTitle, dueDate: self.main.detailsDueDate)
                        self.main.todos.append(newTodo)
                    }
                    self.main.sort()
                    do{
                        let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.main.todos, requiringSecureCoding: false)
                        UserDefaults.standard.set(archivedData, forKey: "todos")
                    } catch{
                        print("error")
                    }
                    self.main.detailsShowing = false
                }){
                    
                    Text(editingMode ? "Confirm" : "Add").padding()
                }
                .disabled(main.detailsTitle == "")
            }
            SATextField(tag: 0, text: editingTodo.title, placeholder: "inpput", changeHandler: {(newString) in  self.main.detailsTitle = newString
            }){
                
            }
            .padding()
            .foregroundColor(.white)
            DatePicker(selection: $main.detailsDueDate,displayedComponents: .date,label: {()->EmptyView in
            })
            .padding()
            Spacer()
        }
    .padding()
    .background(Color("todoDetails-bg"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TodoDetails_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetails(main: Main())
    }
}
