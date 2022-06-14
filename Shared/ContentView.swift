import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    var body: some View {
        VStack {
            Text(model.displayedMessage)
                .font(.title2)
                .bold()
                .opacity(model.isAnimating ? 0 : 1)
                .animation(.default, value: model.isAnimating)
            
            Spacer()
            
            GridView(model: model,
                     lineWidth: 7.5)
            .padding()
            
            Spacer()
            
            HStack {
                Button {
                    Task {
                        await model.switchGameMode()
                    }
                } label: {
                    Image(systemName: model.isPVE ? "person" : "person.2")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button {
                    Task {
                        await model.startNewGame()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.red)
                }
            }
            .buttonStyle(.plain)
            .symbolVariant(.fill.circle)
            .symbolRenderingMode(.multicolor)
            .font(.title)
        }
        .padding()
        #if os(macOS)
        .frame(minWidth: 350, minHeight: 400)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
