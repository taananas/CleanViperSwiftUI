//
//  TripDetailView.swift
//  Viper SwiftUI
//
//  Created by Богдан Зыков on 02.09.2022.
//

import SwiftUI

struct TripDetailView: View {
    @ObservedObject var presenter: TripDetailPresenter
    var body: some View {
        VStack{
            tripTextField
            presenter.makeMapView()
            Text(presenter.distanceLabel)
            HStack {
              Spacer()
              EditButton()
              Button(action: presenter.addWaypoint) {
                Text("Add")
              }
            }.padding([.horizontal])
            List {
              ForEach(presenter.waypoints, content: presenter.cell)
                .onMove(perform: presenter.didMoveWaypoint(fromOffsets:toOffset:))
                .onDelete(perform: presenter.didDeleteWaypoint(_:))
            }
            .listStyle(.inset)
        }
        .navigationBarTitle(Text(presenter.tripName), displayMode: .inline)
          .navigationBarItems(trailing: Button("Save", action: presenter.save))
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let trip = model.trips[0]
        let mapProvider = RealMapDataProvider()
        let presenter = TripDetailPresenter(interactor: TripDetailInteractor(trip: trip, model: model, mapInfoProvider: mapProvider))
        return NavigationView{
            TripDetailView(presenter: presenter)
        }
    }
}


extension TripDetailView{
    private var tripTextField: some View{
        TextField("Trip Name", text: presenter.setTripName)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
    }
}
