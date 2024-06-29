import SwiftUI

struct ParamsImageSkeleton {
    
    // MARK: Nested Types

    enum WidthParamType {

        case none
        case width(value: CGFloat)
        case maxWidth(value: CGFloat)
        case minWidth(value: CGFloat)
    }

    enum HeightParamType {

        case none
        case height(value: CGFloat)
        case maxHeight(value: CGFloat)
        case minHeight(value: CGFloat)
    }

    // MARK: Internal Properties

    let width: WidthParamType
    let height: HeightParamType

    // MARK: Init

    init(params: Params) {
        if let w = params.skeletonFrame?.width { self.width = .width(value: w.value) }
        else if let w = params.skeletonFrame?.maxWidth { self.width = .maxWidth(value: w.value) }
        else if let w = params.skeletonFrame?.minWidth { self.width = .minWidth(value: w.value) }
        else { self.width = .none }

        if let h = params.skeletonFrame?.height { self.height = .height(value: h.value) }
        else if let h = params.skeletonFrame?.maxHeight { self.height = .maxHeight(value: h.value) }
        else if let h = params.skeletonFrame?.minHeight { self.height = .minHeight(value: h.value) }
        else { self.height = .none }
    }
}
