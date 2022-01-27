//
//  ContentView.swift
//  WeeklyWeather
//
//  Created by soohong ahn on 2021/08/13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var time = TimeManager()
    @State var CF_Toggle = true
    @State var degreeUnit = "°C"
    @State var darkMode = false
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                if (darkMode) {
                    Color.background_dark.ignoresSafeArea()
                } else {
                    Color.background_light.ignoresSafeArea()
                }
                VStack(spacing: g.size.height * 0.02){
                    HStack(){
                        Spacer()
                        Button(action: {
                            CF_Toggle ? (degreeUnit = "°F") : (degreeUnit = "°C")
                            CF_Toggle.toggle()
                        }, label: {
                            Text(CF_Toggle ? "°F" : "°C")
                                .font(Font.custom("Alexis Marie", size: g.size.width * 0.09))
                                .frame(width: g.size.width * 0.15, height: g.size.width * 0.15, alignment: .center)
                                .padding(.trailing, g.size.width * 0.02)

                        })
                    }
                    Text(viewModel.city.uppercased())
                        .font(Font.custom("Alexis Marie", size: g.size.width * 0.15))
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.1)
                        .fixedSize()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Text("\(viewModel.description)")
                        .font(Font.custom("Alexis Marie", size: g.size.width * 0.07))

                    Image("\(viewModel.changeIconToDark(originalID: viewModel.iconName, darkMode: darkMode))")
                        .resizable()
                        .scaledToFit()
                        .frame(width: g.size.height * 0.25, height: g.size.height * 0.25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("\(CF_Toggle ? viewModel.temp : viewModel.convertCtoF(tempC: viewModel.temp))\(degreeUnit)")
                        .font(Font.custom("Alexis Marie", size: g.size.width * 0.18))

                    Text("feels like \(CF_Toggle ? viewModel.feels_like : viewModel.convertCtoF(tempC: viewModel.feels_like))\(degreeUnit)")
                        .font(Font.custom("Alexis Marie", size: g.size.width * 0.07))

                    HStack(spacing: g.size.width * 0.45){
                        VStack (spacing: g.size.height * 0.02){
                            Text("LOW")
                                .font(Font.custom("Alexis Marie", size: g.size.width * 0.075))
                            Text("\(CF_Toggle ? viewModel.temp_min : viewModel.convertCtoF(tempC: viewModel.temp_min))\(degreeUnit)")
                                .font(Font.custom("Alexis Marie", size: g.size.width * 0.075))
                        }
                        VStack (spacing: g.size.height * 0.02){
                            Text("HIGH")
                                .font(Font.custom("Alexis Marie", size: g.size.width * 0.075))
                            Text("\(CF_Toggle ? viewModel.temp_max : viewModel.convertCtoF(tempC: viewModel.temp_max))\(degreeUnit)")
                                .font(Font.custom("Alexis Marie", size: g.size.width * 0.075))


                        }
                    }.padding(.top, g.size.height * 0.07)
                }
                .frame(width: g.size.width, height: g.size.height)
                .foregroundColor(darkMode ? Color.font_light : Color.font_dark)
            }.onAppear(perform: {
                if (time.hour > 5 && time.hour < 19) {
                    darkMode = false
                } else {
                    darkMode = true
                }
            })
        }.onAppear(
            perform: {
                viewModel.refresh()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(weatherService: WeatherService()))
    }
}
