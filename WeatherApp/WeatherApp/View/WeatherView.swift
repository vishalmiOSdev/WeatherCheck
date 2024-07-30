//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vishal Manhas on 19/06/24.
//

import SwiftUI


struct WeatherView: View {
    @State private var city = ""
    @State private var isFetchingWeather = false
    @State private var weather: WeatherResponse?
    @State private var showWeather = false
    
    let viewModel = WeatherViewModel()
   
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                TextField("Enter city", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        isFetchingWeather = true
                    }
                    .task(id: isFetchingWeather) {
                        if isFetchingWeather {
                            await viewModel.getCoordinatesByCity(city)
                            weather = viewModel.weatherResponse
                            isFetchingWeather = false
                            withAnimation {
                                showWeather = true
                            }
                        }
                    }
                
                if isFetchingWeather {
                    ProgressView()
                        .scaleEffect(2)
                        .padding()
                } else if let weather = weather, showWeather {
                    VStack {
                        Text("Temperature")
                            .font(.headline)
                            .padding(.top)
                        Text("\(kelvinToCelsius(weather.main?.temp ?? 0.0), specifier: "%.1f")°C")
                            .font(.largeTitle)
                            .bold()
                            .transition(.slide)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.8))
                    )
                    .padding()
                }
                Spacer()
            }
            .padding()
        }
    }
    
    private func kelvinToCelsius(_ kelvin: Double) -> Double {
          return kelvin - 273.15
      }
}


#Preview {
    WeatherView()
    
}
