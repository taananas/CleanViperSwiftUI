//
//  TripListPresenter.swift
//  Viper SwiftUI
//
//  Created by Богдан Зыков on 01.09.2022.
//

import Combine
import SwiftUI

class TripListPresenter: ObservableObject{
    
    private let interactor: TripListInteractor

    private let router = TripListRouter()
    
    @Published var trips: [Trip] = []
    private var cancellables = Set<AnyCancellable>()


    init(interactor: TripListInteractor) {
        self.interactor = interactor
        startTripSubscription()
    }
    
    public func makeAddNewButton() -> some View {
      Button(action: addNewTrip) {
        Image(systemName: "plus")
      }
    }
    
    
    public func deleteTrip(_ index: IndexSet) {
        withAnimation {
            interactor.deleteTrip(index)
        }
    }
    
    public func linkBuilder(for trip: Trip) -> some View {
        NavigationLink("", destination: router.makeDetailView(for: trip, model: interactor.model))
    }
    
    private func addNewTrip() {
        withAnimation {
            interactor.addNewTrip()
        }
    }
    
    private func startTripSubscription(){
        interactor.model.$trips
            .assign(to: \.trips, on: self)
            .store(in: &cancellables)
    }
    

}

