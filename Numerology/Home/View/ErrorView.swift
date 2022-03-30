//
//  ErrorView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var vm: MessageListViewModel
    
    var body: some View {
        VStack {
            Text("🤷‍♂️")
                .font(.system(size: 80))
            Text(vm.errorMessage ?? "Произошла ошибка")
                .padding()
            
            Button {
                vm.loadMessagesData()
            } label: {
                Text("Попробовать снова...")
                    .font(.headline)
                    .padding()
                    .background(
                        Capsule()
                            .stroke(lineWidth: 2)
                    )
            }
            .accentColor(Color.blue)

        }
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ErrorView(vm: dev.messageListVM)
            ErrorView(vm: dev.messageListVM).preferredColorScheme(.dark)
        }
        
    }
}
