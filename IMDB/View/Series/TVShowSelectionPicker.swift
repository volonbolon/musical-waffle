//
//  TVShowSelectionPicker.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 23/07/2021.
//

import SwiftUI

struct TVShowSelectionPicker: View {
    @Binding var selectedOption: Int
    
    var body: some View {
        Picker(selection: $selectedOption,
               label: Text("Picker"),
               content: {
                Text(TVShowDataModel.Option.popular.description).tag(TVShowDataModel.Option.popular.rawValue)
                Text(TVShowDataModel.Option.topRated.description).tag(TVShowDataModel.Option.topRated.rawValue)
        })
            .pickerStyle(SegmentedPickerStyle())
    }
}
