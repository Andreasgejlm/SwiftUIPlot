import SwiftUI

@available (iOS 13.0, *)
public struct SwiftUIPlot: View {
    var text = "Hello, World!"
    
    public init() {
        
    }
    
    public var body: some View {
        Text(text)
    }
    
}


@available (iOS 13.0, *)
struct SwiftUIPlot_Previews: PreviewProvider {
    
    static var previews: some View {
        SwiftUIPlot()
    }
    
}
