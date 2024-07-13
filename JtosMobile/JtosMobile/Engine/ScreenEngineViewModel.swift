import Foundation
import SwiftUI

class ScreenEngineViewModel: ObservableObject {
    
    let query: ScreenQuery
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore

    @Published var loading: Bool = false
    @Published var error: Error? = nil
    @Published var screenResponse: ScreenResponse? = nil
    
    init(
        query: ScreenQuery,
        actionDispatcher: ActionDispatcher,
        stateStore: StateStore
    ) {
        self.query = query
        self.actionDispatcher = actionDispatcher
        self.stateStore = stateStore
    }
}

// MARK: - Fetch Data

extension ScreenEngineViewModel {
    func fetchData() {
        loading = true
        
        var urlComponents = Constants.backendUrl
        urlComponents.path = query.path
        urlComponents.queryItems = query.params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: query.body, options: [])
            request.httpBody = jsonData
        } catch {
            loading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = error
                    
                } else if let data = data {
                    do {
                        let screenResponse = try JSONDecoder().decode(ScreenResponse.self, from: data)
                        self.screenResponse = screenResponse
                        self.error = nil
                    } catch {
                        self.error = error
                    }
                }
                self.loading = false
            }
        }.resume()
    }
}

// MARK: - Fetch Patch

extension ScreenEngineViewModel {
    func fetchPatch(
        query: ScreenQuery,
        stateStore: StateStore?
    ) {
//        loading = true
        
        var urlComponents = Constants.backendUrl
        urlComponents.path = query.path
        urlComponents.queryItems = query.params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: query.body, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            request.httpBody = jsonData
        } catch {
            self.error = EngineError.unableToDecodeStateToJson
            loading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = error
                    
                } else if let data = data {
                    do {
                        let newScreenResponse = try JSONDecoder().decode(ScreenResponse.self, from: data)
                        self.screenResponse = newScreenResponse
                        self.error = nil
                    } catch {
                        self.error = error
                    }
                }
                self.loading = false
            }
        }.resume()
    }
    
}
extension ScreenEngineViewModel {
    
    enum Constants {
        static let backendUrl = URLComponents(string: "http://localhost:8080")!
    }
}
