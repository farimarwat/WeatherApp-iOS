//
//  ContentView.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var vm:WeatherViewModel
    
    @State var showLocationSelector = false
    @State var locationName = ""

    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment:.center){
                    switch vm.loadStatus {
                    case .notLoading:
                        ProgressView()
                    case .loading:
                        ProgressView()
                    case .successfull:
                        if let details =  vm.weather {
                            VStack{
                                //Top
                                VStack{
                                    Text(details.name ?? "")
                                        .font(.largeTitle)
                                    HStack(alignment:.center){
                                        AsyncImage(url: details.iconUrl) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(width: 200)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        VStack{
                                            //Centigrade
                                            Text(String(details.tempC))
                                                .font(.largeTitle)
                                            Text(details.condition ?? "")
                                                .font(.caption)
                                        }
                                    }
                                }
                                .frame(maxWidth:.infinity)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .clipShape(.rect(cornerRadius: 20))
                                .padding(.top,80)
                                .padding()
                                .shadow(radius: 20,x: 10,y:5)
                                
                                //Bottom
                                
                                HStack(alignment: .center, spacing: 50){
                                    
                                    //FeelLike
                                    VStack{
                                        Text("Feels Like")
                                            .font(.title2)
                                        Text(String(details.feelsLikeC))
                                            .font(.title3)
                                    }
                                    //UV
                                    VStack{
                                        Text("UV")
                                            .font(.title2)
                                        Text(String(details.uv))
                                    }
                                    //
                                    VStack{
                                        Text("Humidity")
                                            .font(.title2)
                                        Text(String(details.humidity))
                                    }
                                }
                                .padding()
                                .frame(maxWidth:.infinity)
                                .background(Color.red.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 20))
                                .padding()
                                
                                if let forecasts = details.forecasts as? Set<ForecastEntity> {
                                    let forecastArray = Array(forecasts)
                                    ScrollView(.horizontal) {
                                        HStack{
                                            ForEach(forecastArray, id: \.self) { item in
                                                let model = ForecastModel(
                                                    time: item.time!,
                                                    tempC: item.tempC,
                                                    conditionText: item.conditionText!,
                                                    icon: item.icon!)
                                                ForecastItem(item: model)
                                            }
                                        }
                                    }
                                }

                            }
                        }
                        else {
                            VStack(alignment: .center){
                                Text("No Location Found")
                                Button {
                                    showLocationSelector.toggle()
                                } label: {
                                    Text("Add Location")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .frame(maxHeight:.infinity)
                        }
                    case .error(let error):
                        Text("\(error)")
                    }
                    Spacer()
                }
                .frame(maxHeight:.infinity)
                .onAppear{
                    Task{
                        await vm.get()
                    }
                }
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color.white)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showLocationSelector.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }

                }
            }
            .sheet(isPresented: $showLocationSelector) {
                ListLocationsView(){item in
                    Task{
                        await vm.add(response: item)
                    }
                    showLocationSelector.toggle()
                }
            }
        }
        .environmentObject(vm)
        
    }
  
}


#Preview {
    @Previewable @StateObject var vm = Injector.shared.providesWeatherViewModel()
    NavigationView {
        ContentView()
    }
    .environmentObject(vm)
}
