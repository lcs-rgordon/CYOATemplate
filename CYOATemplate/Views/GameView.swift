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
            
            EdgesView(forNodeWithId: currentNode, currentNode: $currentNode)
                        
            Spacer()
            
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
