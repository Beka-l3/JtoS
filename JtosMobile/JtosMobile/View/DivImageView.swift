import SwiftUI

struct DivImageView: View {
    
    let divImage: DivImage
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore
//    var cachedImage: Image
    
    var body: some View {
        buildImageView(divImage)
    }
    
    
    @ViewBuilder
    private func buildImageView(_ imageData: DivImage) -> some View {
        
        AsyncImage(url: URL(string: imageData.imageUrl)) { image in
            let _ = ImageCache.setImageForId(id: imageData.imageUrl, image: image)
            image
                .resizable()
                .aspectRatio(contentMode: imageData.contentMode.toSwiftUI())
                .frame(
                    width: imageData.width.getSize(),
                    height: imageData.height.getSize()
                )
                .frame(
                    maxWidth: imageData.width.getMaxSize(),
                    maxHeight: imageData.height.getMaxSize()
                )
                .padding(imageData.padding.toSwiftUI())
        } placeholder: {
            ImageCache.getImage(for: imageData.imageUrl)
                .resizable()
                .aspectRatio(contentMode: imageData.contentMode.toSwiftUI())
                .frame(
                    width: imageData.width.getSize(),
                    height: imageData.height.getSize()
                )
                .frame(
                    maxWidth: imageData.width.getMaxSize(),
                    maxHeight: imageData.height.getMaxSize()
                )
                .padding(imageData.padding.toSwiftUI())
        }
        .id(URL(string: imageData.imageUrl))
    }
}
