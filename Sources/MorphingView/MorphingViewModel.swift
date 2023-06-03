//
//  MorphingViewModel.swift
//  
//
//  Created by Kristóf Kálai on 2023. 06. 03..
//

import Combine
import SwiftUI

public final class MorphingViewModel: ObservableObject {
    private enum Constant {
        static let maxBlurRadius: Double = 40
        static let midBlurRadius = maxBlurRadius / 2
        static let blurStep = maxBlurRadius / 80
    }

    @Published private var blurRadius: Double = .zero
    @Published private var changed = false

    let alphaThreshold: Double
    let updatePublisher: AnyPublisher<Void, Never>

    public init(alphaThreshold: Double = 0.5) {
        self.alphaThreshold = alphaThreshold
        updatePublisher = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

extension MorphingViewModel {
    var blur: Double {
        blurRadius >= Constant.midBlurRadius ? Constant.maxBlurRadius - blurRadius : blurRadius
    }

    func update(image: () -> Void, finished: () -> Void) {
        if blurRadius <= Constant.maxBlurRadius {
            blurRadius += Constant.blurStep
        }

        if blurRadius.rounded() >= Constant.midBlurRadius && !changed {
            changed = true
            image()
        }

        if blurRadius.rounded() == Constant.maxBlurRadius {
            blurRadius = 0
            finished()
            changed = false
        }
    }
}
