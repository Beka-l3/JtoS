import SwiftUI

struct ParamsTabbar {

    // MARK: Nested Types

    struct Tabbar {

        // MARK: Nested Types

        enum IconType {

            case systemImage(systemName: String)
            case url(url: URL?)
        }

        enum RootSourceType {

            case url(string: String)
            case mock(filename: String)
        }

        // MARK: Internal Properties

        var tag: Int
        var title: String

        var iconType: IconType
        var rootSourceType: RootSourceType

        var tintColor: Color
    }

    // MARK: Internal Properties

    var tabbars: [Tabbar]
    var tabbarVarId: String

    // MARK: Init

    init(params: Params) {
        self.tabbarVarId = params.tabbarVarId ?? "var.tabbar.0"
        self.tabbars = []

        if let tabbars = params.tabbars {
            for tb in tabbars {
                let iconType: Tabbar.IconType
                if let ur = tb.imageUrl {
                    iconType = .url(url: URL(string: ur))
                } else {
                    iconType = .systemImage(systemName: tb.systemImage ?? "")
                }

                let rootSourceType: Tabbar.RootSourceType
                if let urlString = tb.url {
                    rootSourceType = .url(string: urlString)
                } else {
                    rootSourceType = .mock(filename: tb.mock ?? "empty")
                }

                self.tabbars.append(.init(
                    tag: tb.tag,
                    title: tb.title ?? "",
                    iconType: iconType,
                    rootSourceType: rootSourceType,
                    tintColor: Color.fromHex(tb.tintColor ?? "")
                ))
            }
        }
    }
}
