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
    @State var currentNodeId: Int = 1
    
    // The list of movies produced by joining the Movie and Genre tables
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) as Count FROM Node WHERE Node.visits > 0")
    }) var nodesVisited
    
    // MARK: Computed properties
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("A total of \(nodesVisited.results.first?["Count"]?.intValue ?? 0) nodes have been visited in this story.")
            
            Divider()
            
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
            
            Divider()
            
            EdgesView(currentNodeId: $currentNodeId)
                        
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
