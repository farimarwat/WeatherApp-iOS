//
//  ListLocationsView.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import SwiftUI

struct ListLocationsView: View {
    @EnvironmentObject var vm:WeatherViewModel
    @State var locationName = ""
    
    let onItemSelected:(WeatherResponse) -> Void
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type country name",text: $locationName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: locationName) {newValue in
                        Task{
                            await vm.fetchLocations(for: newValue)
                        }
                    }
                
                switch vm.fetchStatus {
                case .notloading:
                    Text("No data to show")
                        .font(.title)
                        .foregroundColor(Color.white)
                case .loading:
                    ProgressView()
                case .successful:
                    ForEach(vm.locations, id: \.self.id){item in
                        LocationView(weather: item){item in
                            onItemSelected(item)
                        }
                    }
                case .error(let error):
                    Text("\(error)")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
        }
        .background(Color("ColorBackground"))
    }
}

#Preview {
    let vm = Injector.shared.providesWeatherViewModel()
    ListLocationsView(){item in}
        .environmentObject(vm)
}
