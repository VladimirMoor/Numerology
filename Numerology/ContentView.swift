//
//  ContentView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 28.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = MessageListViewModel()
    
    var body: some View {
        
        if vm.isLoading {
            LoadingView()
        } else if (vm.errorMessage != nil) && (vm.isListLoaded != true) {
            ErrorView(vm: vm)
        } else {
            MessageListView(vm: vm)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
