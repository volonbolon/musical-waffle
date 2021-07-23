//
//  MovieSelectionPicker.swift
//  IMDB
//
//  Created by Ariel Rodriguez on 21/07/2021.
//

import SwiftUI

struct MovieSelectionPicker: View {
    @Binding var selectedOption: Int
    
    var body: some View {
        Picker(selection: $selectedOption,
               label: Text("Picker"),
               content: {
                Text(MovieDataModel.Option.popular.description).tag(MovieDataModel.Option.popular.rawValue)
                Text(MovieDataModel.Option.topRated.description).tag(MovieDataModel.Option.topRated.rawValue)
                Text(MovieDataModel.Option.upcoming.description).tag(MovieDataModel.Option.upcoming.rawValue)
        })
            .pickerStyle(SegmentedPickerStyle())
    }
}
