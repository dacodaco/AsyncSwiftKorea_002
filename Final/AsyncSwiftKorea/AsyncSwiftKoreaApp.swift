import SwiftUI

@main
struct AsyncSwiftKoreaApp: App {
    
    let chamChamViewModel = ChamChamViewModel(moon: Moon())
    
    var body: some Scene {
        WindowGroup {
            ChamChamView(viewModel: chamChamViewModel)
        }
    }
}
