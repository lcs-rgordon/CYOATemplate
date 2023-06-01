//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNode: Int = 1
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("\(currentNode)")
                    .font(.largeTitle)
                Spacer()
            }
            
            NodeView(forNodeWithId: currentNode)
            
            Divider()
            
//            ForEach(storyNodes[currentNode].edges, id: \.self) { currentEdge in
//                
//                Text("\(currentEdge.prompt)")
//                    .onTapGesture {
//                        withAnimation {
//                            currentNode = currentEdge.destinationId
//                        }
//                    }
//                
//            }
            
            Spacer()
            
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
