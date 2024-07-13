import SwiftUI
import Combine

struct ScreenEngineView: View {
    
    @ObservedObject var viewModel: ScreenEngineViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if viewModel.loading {
                    ProgressView()
                } else if let screenResponse = viewModel.screenResponse {
                    ScreenView(viewModel: viewModel, screenResponse: screenResponse)
                } else if let error = viewModel.error {
                    ErrorView(viewModel: viewModel, error: error)
                } else {
                    NoDataView(viewModel: viewModel)
                }
            }
        }
        .refreshable {
            viewModel.fetchData()
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
    
    struct ScreenView: View {
        
        @ObservedObject var viewModel: ScreenEngineViewModel
        var screenResponse: ScreenResponse
        
        var body: some View {
            ForEach(screenResponse.ui, id: \.self.id) { section in
                SectionView(section: section, actionDispatcher: viewModel.actionDispatcher)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
           }
        }
    }
    
    struct ErrorView: View {
        
        @ObservedObject var viewModel: ScreenEngineViewModel
        var error: Error

        var body: some View {
            Text("Error: \(error.localizedDescription)")
            Button("Reload", action: viewModel.fetchData)
        }
    }
    
    struct NoDataView: View {
        
        @ObservedObject var viewModel: ScreenEngineViewModel
        
        var body: some View {
            Text("No data available")
            Button("Reload", action: viewModel.fetchData)
        }
    }
}
