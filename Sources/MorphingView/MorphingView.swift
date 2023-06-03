//
//  MorphingView.swift
//
//
//  Created by Kristóf Kálai on 2023. 06. 03..
//

import SwiftUI
import Combine

public struct MorphingView {
    @State private var image: Image
    @StateObject private var vm: MorphingViewModel
    @Binding private var animate: Bool
    private let imageUpdater: (Image?) -> Image

    public init(animate: Binding<Bool>, vm: MorphingViewModel = .init(), imageUpdater: @escaping (Image?) -> Image) {
        self._animate = animate
        self._vm = .init(wrappedValue: vm)
        self.imageUpdater = imageUpdater
        self.image = imageUpdater(nil)
    }
}

extension MorphingView: View {
    public var body: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: vm.alphaThreshold))
            context.addFilter(.blur(radius: vm.blur))

            context.drawLayer { context in
                if let resolvedImage = context.resolveSymbol(id: 1) {
                    context.draw(resolvedImage, at: .init(x: size.width / 2, y: size.height / 2), anchor: .center)
                }
            }
        } symbols: {
            image
                .resizable()
                .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: image)
                .tag(1)
        }
        .onReceive(vm.updatePublisher) { _ in
            if animate {
                vm.update(image: {
                    image = imageUpdater(image)
                }, finished: {
                    animate = false
                })
            }
        }
    }
}
