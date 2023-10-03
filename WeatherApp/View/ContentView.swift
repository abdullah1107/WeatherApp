//
//  ContentView.swift
//  WeatherApp
//
//  Created by Muhammad Mamun on 2/10/23.

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @State private var workItem: DispatchWorkItem?
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Divider()
            
            Text("\(weatherViewModel.weatherInfo)")
                .font(.body)
                .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { _ in
            self.workItem?.cancel()
            let newWorkItem = DispatchWorkItem {
                if !self.input.isEmpty {
                    self.weatherViewModel.fetch(city: self.input)
                }
            }
            self.workItem = newWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: newWorkItem)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
