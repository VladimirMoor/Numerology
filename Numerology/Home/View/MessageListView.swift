//
//  MessageListView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import SwiftUI

struct MessageListView: View {
    
    @ObservedObject var vm: MessageListViewModel
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Messages")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.blue)
                Spacer()
                Text("Error message here ")
                    .foregroundColor(Color.secondary)
            }
            .padding()
            .background(Color.theme.background.ignoresSafeArea(.all, edges: .top))
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                GeometryReader { reader -> AnyView in
                    
                    DispatchQueue.main.async {
                        if refresh.startOffset == 0 {
                            refresh.startOffset = reader.frame(in: .global).minY
                        }
                        
                        refresh.offset = reader.frame(in: .global).minY
                        
                        if refresh.offset - refresh.startOffset > 80 && !refresh.started {
                            refresh.started = true
                        }
                        
                        if refresh.startOffset == refresh.offset && refresh.started && !refresh.released {
                            withAnimation(.linear) {
                                refresh.released = true
                            }
                            
                            print("update1")
                        }
                        
                        if refresh.startOffset == refresh.offset && refresh.started && refresh.released && refresh.invalid {
                            refresh.invalid = false
                            print("updeate2")
                        }

                    }
                    
                    return AnyView(EmptyView())
                }
                .frame(width: 0, height: 0)
                
                ZStack(alignment: .top) {
                    
                    if refresh.started && refresh.released {
                        ProgressView()
                            .offset(y: -35)
                        
                    } else {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.gray)
                            .rotationEffect(Angle(degrees: refresh.started ? 180 : 0 ))
                            .offset(y: -25)
                            .animation(.easeIn)
                    }

                    
                    VStack {
                        ForEach(0..<vm.messages.count) { index in
                            HStack {
                                Text(vm.messages[index])
                                    .foregroundColor(Color.theme.accent)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                        }
                    }
                    .background(Color.theme.background)
                }
                .offset(y: refresh.released ? 40 : -10)
                
            }

        }
        .background(Color.theme.listBackground.ignoresSafeArea())

    }
}

struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
    var invalid: Bool = false
}



struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            MessageListView(vm: dev.messageListVM)
            MessageListView(vm: dev.messageListVM).preferredColorScheme(.dark)
        }
       
    }
}
