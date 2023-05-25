//
//  DaysListView.swift
//  Weather API
//
//  Created by Ivan Kopych on 17.05.2023.
//

import SwiftUI

struct DaysListView: View {
    var dailyForecast: [DayForecastModel]
    
    var body: some View {
        List {
            ForEach(dailyForecast, id: \.id) { item in
                NavigationLink(destination: DetailScreen(dayForecast: item)) {
                    DayView(forecast: item)
                }
            }.listRowInsets(EdgeInsets(
                top: 0, leading: 10, bottom: 10, trailing: 10))
        }
    }
}

struct DaysCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DaysListView(dailyForecast: [])
    }
}
