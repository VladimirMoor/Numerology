//
//  LoadingView.swift
//  Numerology
//
//  Created by Владимир Муравьев on 29.03.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("📥")
                .font(.system(size: 80))
            ProgressView()
                .padding()
            Text("Идет загрузка сообщений...")
                .font(.headline)
                .foregroundColor(Color.theme.accent)

        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView()
            LoadingView().preferredColorScheme(.dark)
        }
        
    }
}
