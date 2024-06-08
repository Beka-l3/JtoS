import Foundation

extension JtoS {

    func traverseModel(idx: Int = 0) {
        spcPrint(idx) { print(type, jToSType) }
        spcPrint(idx) { print(params) }

        spcPrint(idx) { print("{") }
        for elem in ui {
            elem.traverseModel(idx: idx + 1)
            print("")
        }
        spcPrint(idx) { print("}") }
    }
    
    func spcPrint(
        _ times: Int,
        _ symbol: String = "  ",
        _ completion: (() -> Void)?
    ) {
        guard times >= 0, !symbol.isEmpty else { return }

        for _ in 0..<times {  print(symbol, terminator: "")  }
        completion?()
    }
}
