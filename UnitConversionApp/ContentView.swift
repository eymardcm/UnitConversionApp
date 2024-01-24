//
//  ContentView.swift
//  UnitConversionApp
//
//  Created by Chad Eymard on 1/23/24.
//

import SwiftUI


private struct Unit: Identifiable, Hashable {
    let singularName: String
    let pluralName: String
    let nameAbbrevriation: String
    let mlUnitVal: Double
    var id: String { singularName }
}

struct ContentView: View {
    
    @State private var units: [Unit] = [
        Unit(singularName: "milliliter", pluralName: "milliliters", nameAbbrevriation: "ml", mlUnitVal: 1.0),
        Unit(singularName: "liter", pluralName: "liters", nameAbbrevriation: "L", mlUnitVal: 1000.0),
        Unit(singularName: "cup", pluralName: "cups", nameAbbrevriation: "c", mlUnitVal: 237.0),
        Unit(singularName: "pint", pluralName: "pints", nameAbbrevriation: "pt", mlUnitVal: 473.0),
        Unit(singularName: "gallon", pluralName: "gallons", nameAbbrevriation: "gal", mlUnitVal: 3785.41)]
    
    @State private var xUnit: Unit = Unit(singularName: "milliliter", pluralName: "milliliters", nameAbbrevriation: "ml", mlUnitVal: 1.0)
    @State private var yUnit: Unit = Unit(singularName: "milliliter", pluralName: "milliliters", nameAbbrevriation: "ml", mlUnitVal: 1.0)
    @State private var xValue: Double = 0.0
    @FocusState private var unitsToConvertIsFocused: Bool
    
    private var result: String {
        
        get {
            let result = (xUnit.mlUnitVal / yUnit.mlUnitVal) * xValue
            let yQuantity = xValue * yUnit.mlUnitVal
            
            let xUnitsName =  xValue > 1 ? xUnit.pluralName : xUnit.singularName
            let yUnitsName =  result > 1 ? yUnit.pluralName : yUnit.singularName
            return "\(xValue) \(xUnitsName) = \(result) \(yUnitsName)"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("units quantity") {
                    TextField("unitsQuantity", value: $xValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($unitsToConvertIsFocused)
                }
                Section("Convert from unit"){
                    Picker("unit", selection: $xUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.pluralName)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Convert to unit"){
                    Picker("unit", selection: $yUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.pluralName)
                        }
                    }.pickerStyle(.navigationLink)
                    
                }
                Text("\(result)")
            }
            .navigationTitle("Volume Conversions")
            
        }
    }
}

#Preview {
    ContentView()
}
