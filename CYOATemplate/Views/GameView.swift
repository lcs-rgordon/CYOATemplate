//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNode: Int = 1
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
            
            ForEach(storyNodes[currentNode].paragraphs, id: \.self) { currentParagraph in
                
                Text(currentParagraph)
                
            }
            
            Divider()
            
            ForEach(storyNodes[currentNode].edges, id: \.self) { currentEdge in
                
                Text("\(currentEdge.prompt)")
                    .onTapGesture {
                        withAnimation {
                            currentNode = currentEdge.destinationId
                        }
                    }
                
            }
            
            
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
