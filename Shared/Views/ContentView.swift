import SwiftUI

struct ContentView: View {
    @AppStorage("appearance") var appearance = Appearance.system
    
    /// The view model.
    @StateObject private var grid = GameGrid()
    
    var body: some View {
        GeometryReader { proxy in
            // 10% padding.
            GridView(length: 0.8 * min(proxy.size.width, proxy.size.height))
            // Center the grid.
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .navigationTitle(grid.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                RestartButton()
                #if os(macOS)
                SwitchGameModeButton()
                #endif
            }
            #if os(iOS)
            ToolbarItem(placement: .navigationBarLeading) {
                Menu {
                    SwitchGameModeButton()
                    DifficultyPicker()
                        .pickerStyle(.menu)
                    AppearancePicker()
                        .pickerStyle(.menu)
                } label: {
                    Label("settings", systemImage: "gear")
                }
            }
            #endif
        }
        .preferredColorScheme(appearance.preferredColorScheme)
        .environmentObject(grid)
        #if os(iOS)
        .modifier(NavigationStack())
        #endif
    }
}

#if os(iOS)
/// A modifier that wraps a view in a navigation stack.
struct NavigationStack: ViewModifier {
    func body(content: Content) -> some View {
        NavigationView {
            content
        }
        .navigationViewStyle(.stack)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
