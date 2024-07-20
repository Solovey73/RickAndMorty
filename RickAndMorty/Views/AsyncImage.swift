//
//  AsyncImage.swift
//  RickAndMorty
//
//  Created by Вячеслав Круглов on 18.07.2024.
//

import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (Image) -> Image

    init(
        url: URL?,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image:  @escaping (Image) -> Image
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if let uiImage = loader.image {
                image(Image(uiImage: uiImage))
            } else {
                placeholder
            }
        }
    }
}

private class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}
