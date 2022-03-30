//
//  MessageListViewModel.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import Foundation
import Combine

class MessageListViewModel: ObservableObject {
    
    @Published var messages: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMessagesData()
    }
    
    func loadMessagesData() {
        isLoading = true
        errorMessage = nil
        getMessagesFromServer()
        
    }
    
    private func getMessagesFromServer() {
 
        guard let url = URL(string: "https://a-prokudin.node-api.numerology.dev-01.h.involta.ru/getMessages?offset=0") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main) 
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return data
            }
            .decode(type: Messages.self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                
                self?.isLoading = false
                
                switch completion {
                    
                case .finished:
                    print("Finished")
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.errorMessage = "При подключении к серверу произошла ошибка. Проверьте подключение к сети и повторите попытку позже..."
                }
                
            } receiveValue: { [weak self] message in
                
                self?.messages = message.result
            }
            .store(in: &cancellables)

    }
    
    
}
