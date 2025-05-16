//
//  ContentView.swift
//  FacebookAnimation
//
//  Created by Adrian Suryo Abiyoga on 26/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var x: Int = 0
    @State var finish = false
    @State var txt = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Image("Like")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: (self.x == 1 && !self.finish) ? -55 : 0)
                
                Image("Love")
                    .resizable()
                    .frame(width: 50, height: 55)
                    .offset(y: (self.x == 2 && !self.finish) ? -55 : 0)
                
                Image("Haha")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: (self.x == 3 && !self.finish) ? -55 : 0)
                
                Image("Wow")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: (self.x == 4 && !self.finish) ? -55 : 0)
                
                Image("Sad")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: (self.x == 5 && !self.finish) ? -55 : 0)
                
                Image("Angry")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: (self.x == 6 && !self.finish) ? -55 : 0)
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 25).fill(Color("Color")))
            .overlay(Longgesture(x: $x, finish: $finish, txt: $txt))
            .animation(.spring(), value: x) // Updated animation modifier
            
            Text(txt)
                .fontWeight(.heavy)
                .padding(.top, 15)
        }
    }
}

struct Longgesture: UIViewRepresentable {
    let view = UIView()
    @Binding var x: Int
    @Binding var finish: Bool
    @Binding var txt: String
    
    func makeCoordinator() -> Longgesture.Coordinator {
        return Longgesture.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<Longgesture>) -> UIView {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.long(gesture:))))
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Longgesture>) {}
    
    class Coordinator: NSObject {
        var parent: Longgesture
        
        init(parent1: Longgesture) {
            parent = parent1
        }
        
        @objc func long(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                parent.finish = false
                parent.x = 0
            }
            
            if gesture.state == .changed {
                let value = gesture.location(in: parent.view).x
                
                if value > 0 && value < 58 {
                    parent.x = 1
                    parent.txt = "Like"
                } else if value > 58 && value < 108 {
                    parent.x = 2
                    parent.txt = "Love"
                } else if value > 108 && value < 158 {
                    parent.x = 3
                    parent.txt = "Haha"
                } else if value > 158 && value < 208 {
                    parent.x = 4
                    parent.txt = "Wow"
                } else if value > 218 && value < 278 {
                    parent.x = 5
                    parent.txt = "Sad"
                } else if value > 278 && value < 325 {
                    parent.x = 6
                    parent.txt = "Angry"
                }
            }
            
            if gesture.state == .ended {
                parent.finish = true
            }
        }
    }
}

#Preview {
    ContentView()
}
