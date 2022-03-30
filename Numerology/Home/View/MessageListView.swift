//
//  MessageListView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

/*
 Проект на языке Swift.

 Необходимо реализовать экран со списком сообщений с возможностью подгрузки сообщений с сервера.
 Сообщения должны располагаться снизу вверх друг за другом в порядке, присланном с сервера. Пользователь может скроллить сообщения сверху вниз (как в телеграме и других мессенджерах). Как только пользователь доскроллил до верха, подгружать следующую пачку сообщений, и так пока сообщения не закончатся. Хронология сообщений должна соблюдаться.

 Можно реализовать любым способом. На выходе должно получится полностью рабочее и интуитивно понятное приложение. При добавлении сообщений экран не должен перескакивать(!). Где идет загрузка - поставить индикатор загрузки. Поддержка светлой и темной темы. Заглушка и попытка повторного запроса на случай отсутствия интернета или невалидного ответа от сервера (будет приходить с некоторой вероятностью).

 */

import SwiftUI

struct MessageListView: View {

    @ObservedObject var vm: MessageListViewModel
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Messages")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                Spacer()
                Text(vm.errorMessage ?? "")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
                    .lineLimit(1)
    
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
                            
                            updateList()
                        }
                        
                        if refresh.startOffset == refresh.offset && refresh.started && refresh.released && refresh.invalid {
                            refresh.invalid = false
                            updateList()
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
                        ForEach(vm.messages, id: \.self) { message in
                            HStack {
                                Text(message)
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
        .onAppear {
            vm.isListLoaded = true
        }

    }
    
    func updateList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.linear) {
                if refresh.startOffset == refresh.offset {
                    
                    vm.updateMessagesData()
                    refresh.released = false
                    refresh.started = false
                } else {
                    refresh.invalid = true
                }
            }
        }

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
