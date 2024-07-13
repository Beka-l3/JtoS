import SwiftUI
import Combine

struct DivTextView: View {
    
    let divText: DivText
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore

    init(
        divText: DivText,
        actionDispatcher: ActionDispatcher,
        stateStore: StateStore
    ) {
        self.divText = divText
        self.actionDispatcher = actionDispatcher
        self.stateStore = stateStore
        
        if let textVariable = divText.textVariable {
            stateStore.updateVariable(variable: textVariable)
        }
    }
    
    var body: some View {
        buildTextView(divText)
    }
    
    @SwiftUI.State private var variableText: String = ""
    
    private func updateVariableText(textVariable: TextVariable) {
        self.variableText = stateStore.readVariable(variable: textVariable)
    }

    @ViewBuilder
    private func buildTextView(_ textData: DivText) -> some View {
        if let textVariable = textData.textVariable {
            Text(variableText)
                .font(.system(size: CGFloat(textData.fontSize)))
                .frame(
                    width: textData.width.getSize(),
                    height: textData.height.getSize(),
                    alignment: textData.horizontalAlignment.toSwiftUI()
                )
                .frame(
                    maxWidth: textData.width.getMaxSize(),
                    maxHeight: textData.height.getMaxSize(),
                    alignment: textData.horizontalAlignment.toSwiftUI()
                )
                .padding(textData.padding.toSwiftUI())
                .background(Color(uiColor: textData.backgroundColor.toUIColor()))
                .onTapGesture {
                    actionDispatcher.dispatchAction(action: textData.action?.action)
                }
                .onReceive(stateStore.$store) { _ in
                    updateVariableText(textVariable: textVariable)
                }
        } else {
            Text(textData.text ?? "")
                .font(.system(size: CGFloat(textData.fontSize)))
                .frame(
                    width: textData.width.getSize(),
                    height: textData.height.getSize(),
                    alignment: textData.horizontalAlignment.toSwiftUI()
                )
                .frame(
                    maxWidth: textData.width.getMaxSize(),
                    maxHeight: textData.height.getMaxSize(),
                    alignment: textData.horizontalAlignment.toSwiftUI()
                )
                .padding(textData.padding.toSwiftUI())
                .background(Color(uiColor: textData.backgroundColor.toUIColor()))
                .onTapGesture {
                    actionDispatcher.dispatchAction(action: textData.action?.action)
                }
        }
    }
}
