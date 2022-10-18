//
//  ContentView.swift
//  Viper SwiftUI
//
//  Created by Богдан Зыков on 01.09.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                TripListView(presenter:
                                TripListPresenter(interactor:
                                                    TripListInteractor(model: dataModel)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
