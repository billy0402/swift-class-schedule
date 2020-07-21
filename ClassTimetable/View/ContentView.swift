//
//  ContentView.swift
//  ClassTimetable
//
//  Created by Billy on 2020/7/20.
//  Copyright © 2020 NTUB. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            HStack {
                Text("節次")
                    .frame(width: 100)
                    .aspectRatio(3/2, contentMode: .fill)
                ScrollView {
                    Text("ScrollView")
                }
            }
            HStack {
                ScrollView {
                    Text("ScrollView")
                }
                ScrollView {
                    Text("ScrollView")
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
