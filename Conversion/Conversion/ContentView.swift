//
//  ContentView.swift
//  Conversion
//
//  Created by Abul Kalam Azad on 27/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit : TempUnit = .Celsius
    @State private var outputUnit : TempUnit = .Fahrenheit
    @State private var inputNumber : Double = 0.0
    
    private var numberFormatter : NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
        NavigationView {
            Form {
                inputUnitPicker()
                outputUnitPicker()
                inputNumberTextField()
                outputLabel()
            }
            .navigationTitle("Temp Conversion")
        }
    }
    
    private func inputUnitPicker() -> some View {
        Section {
            Picker("Input Unit", selection: $inputUnit) {
                ForEach(TempUnit.allCases, id: \.self) { unit in
                    Text(String(describing: unit))
                }
            }
        } header: {
            Text("Select input unit")
        }
    }
    
    private func outputUnitPicker() -> some View {
        Section {
            Picker("Output Unit", selection: $outputUnit) {
                ForEach(TempUnit.allCases, id: \.self) { unit in
                    Text(String(describing: unit))
                }
            }
        } header: {
            Text("Select output unit")
        }
    }
    
    private func inputNumberTextField() -> some View {
        Section {
            TextField("Input number", value: $inputNumber, formatter: numberFormatter)
                .multilineTextAlignment(.center)
        }
    }
    
    private func conversionLabel(output : Double) -> some View {
        HStack {
            Spacer()
            Text("Conversion:")
                .font(.title)
                .foregroundColor(.green)
            Text(numberFormatter.string(from: NSNumber(value: output)) ?? "__")
        }
    }
    
    private func outputLabel() -> some View {
        Section {
            conversionLabel(output: inputConverstion(value: inputNumber, inputUnit: inputUnit, outputUnit: outputUnit))
                .padding(.trailing)
                .font(.title)
        }
    }
    
    private func inputConverstion(value: Double, inputUnit: TempUnit, outputUnit: TempUnit) -> Double {
        
        let temperature = Temperature()
        
        if (inputUnit == .Celsius && outputUnit == .Kelvin) {
            return temperature.celsiusToKelvin(for: value)
        } else if (inputUnit == .Kelvin && outputUnit == .Celsius) {
            return temperature.kelvinToCelsius(for: value)
        } else if (inputUnit == .Fahrenheit && outputUnit == . Celsius) {
            return temperature.fahrenheitToCelsius(for: value)
        } else if (inputUnit == .Celsius && outputUnit == .Fahrenheit) {
            return temperature.celsiusToFahrenheit(for: value)
        } else if (inputUnit == .Fahrenheit && outputUnit == .Kelvin) {
            return temperature.fahrenheitToKelvin(for: value)
        } else if (inputUnit == .Kelvin && outputUnit == .Fahrenheit) {
            return temperature.kelvinToFahrenheit(for: value)
        } else {
            return value
        }
    }
    
    enum TempUnit : CaseIterable {
        case Celsius
        case Fahrenheit
        case Kelvin
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class Temperature {
    private var celsius: Double
    private var fahrenheit: Double
    private var kelvin: Double
    
    init() {
        self.celsius = 0
        self.fahrenheit = 0
        self.kelvin = 0
    }
    
    public func celsiusToFahrenheit(for value: Double) -> Double {
        return value * 1.8 + 32
    }
    
    public func celsiusToKelvin(for value: Double) -> Double {
        return value + 273.15
    }
    
    public func fahrenheitToCelsius(for value: Double) -> Double {
        return (value - 32) / 1.8
    }
    
    public func fahrenheitToKelvin(for value: Double) -> Double {
        return (value - 32) * 5/9 + 273.15
    }
    
    public func kelvinToCelsius(for value: Double) -> Double {
        return value - 273.15
    }
    
    public func kelvinToFahrenheit(for value: Double) -> Double {
        return (value - 273.15) * 1.8 + 32
    }
}
