//
//  ContentView.swift
//  Example
//
//  Created by Kristóf Kálai on 2023. 06. 03..
//

import SwiftUI
import MorphingView

struct ContentView: View {
    @State private var animate = false

    private let cloudImage = Image(systemName: "cloud.rain.fill")
    private let mapImage = Image(systemName: "map.fill")

    var body: some View {
        VStack {
            MorphingView(animate: $animate) {
                if $0 == nil {
                    return cloudImage
                }
                return $0 == cloudImage ? mapImage : cloudImage
            }
            .frame(width: 300, height: 300)

            Button("Tap me") {
                animate = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
