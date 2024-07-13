import SwiftUI

struct DivImageView: View {
    
    let divImage: DivImage
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore
    
    
    init(
        divImage: DivImage,
        actionDispatcher: ActionDispatcher,
        stateStore: StateStore
    ) {
        self.divImage = divImage
        self.actionDispatcher = actionDispatcher
        self.stateStore = stateStore
        
        if let imageVariable = divImage.imageVariable {
            stateStore.updateVariable(variable: imageVariable)
        }
    }
    
    
    var body: some View {
        if let imageUrl = divImage.imageUrl {
            buildImageView(imageUrl: imageUrl, divImage)
                .onTapGesture {
                    actionDispatcher.dispatchAction(action: divImage.action?.action)
                }
        } else if let imageVariable = divImage.imageVariable {
            buildImageViewFromVariable(imageVariable: imageVariable, divImage)
        }
    }
    
    @SwiftUI.State private var variableIsTrueState: Bool = false

    private func updateVariableUrl(imageVariable: ImageVariable) {
        self.variableIsTrueState = stateStore.readVariable(variable: imageVariable)
    }

    @ViewBuilder
    private func buildImageView(imageUrl: String?, _ imageData: DivImage) -> some View {
        if let imageUrl = imageUrl, let image = ImageCache.getImage(for: imageUrl) {
            buildCachedImage(image: image, imageData)
        } else if let imageUrl = imageUrl {
            loadAndCacheImage(imageUrl: imageUrl, imageData)
        }
    }
    
    @ViewBuilder
    private func buildImageViewFromVariable(imageVariable: ImageVariable, _ imageData: DivImage) -> some View {
        if(variableIsTrueState) {
            buildImageView(imageUrl: imageVariable.trueState, imageData)
                .onTapGesture {
                    actionDispatcher.dispatchAction(action: imageData.action?.action)
                }
                .onReceive(stateStore.$store) { _ in
                    updateVariableUrl(imageVariable: imageVariable)
                }
        } else {
            buildImageView(imageUrl: imageVariable.falseState, imageData)
                .onTapGesture {
                    actionDispatcher.dispatchAction(action: imageData.action?.action)
                }
                .onReceive(stateStore.$store) { _ in
                    updateVariableUrl(imageVariable: imageVariable)
                }
        }
    }
    
    @ViewBuilder
    private func buildCachedImage(image: Image, _ imageData: DivImage) -> some View {
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
    }
    
    @ViewBuilder
    private func loadAndCacheImage(imageUrl: String, _ imageData: DivImage) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            let _ = ImageCache.setImageForId(id: imageUrl, image: image)
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
            ImageCache.getImage(for: imageUrl)
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
        .id(URL(string: imageUrl))
    }
}
