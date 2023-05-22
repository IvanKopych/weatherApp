//
//  SearchScreen.swift
//  Weather API
//
//  Created by Ivan Kopych on 22.05.2023.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject var viewModel = SearchViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        
        List {
            ForEach(viewModel.cities, id: \.self) { city in
                Text(city)
                    .onTapGesture {
                        viewModel.selectedCity = city
                        dismiss()
                    }
                
            }.listRowInsets(EdgeInsets(
                top: 0, leading: 10, bottom: 10, trailing: 10))
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
