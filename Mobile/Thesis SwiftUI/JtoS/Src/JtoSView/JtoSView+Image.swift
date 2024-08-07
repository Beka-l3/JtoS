import SwiftUI

// MARK: View Modifier

struct ApplyImageParams: ViewModifier {

    var params: ParamsImage

    func body(content: Content) -> some View {
        content
    }
}

struct ApplyImageSkeletonParams: ViewModifier {

    var params: ParamsImageSkeleton

    func body(content: Content) -> some View {
        switch (params.width, params.height) {

        case let (.width(w), .height(h)): content.frame(width: w, height: h)
        case let (.width(w), .none): content.frame(width: w)
        case let (.none, .height(h)): content.frame(height: h)

        case let (.maxWidth(w), .none): content.frame(maxWidth: w)
        case let (.maxWidth(w), .maxHeight(h)): content.frame(maxWidth: w, maxHeight: h)
        case let (.maxWidth(w), .minHeight(h)): content.frame(maxWidth: w, minHeight: h)

        case let (.minWidth(w), .none): content.frame(minWidth: w)
        case let (.minWidth(w), .maxHeight(h)): content.frame(minWidth: w, maxHeight: h)
        case let (.minWidth(w), .minHeight(h)): content.frame(minWidth: w, minHeight: h)

        case let (.none, .maxHeight(h)): content.frame(maxHeight: h)
        case let (.none, .minHeight(h)): content.frame(minHeight: h)

        default: content
        }
    }
}

// MARK: Image

extension JtoSView {

    @ViewBuilder
    func imageView(for element: Binding<JtoS>) -> some View {
        let params = ParamsImage(params: element.wrappedValue.params)
        AsyncImage(url: URL(string: element.wrappedValue.params.url ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: params.contentMode)
            } else if phase.error != nil {
                ZStack {
                    Color(UIColor.systemBackground).opacity(0.3)
                    Text("Unable to load image")
                        .foregroundStyle(Color(UIColor.label))
                }
                .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            } else {
                empty
                    .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            }
        }
        .modifier(ApplyImageParams(params: params))
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }
}
