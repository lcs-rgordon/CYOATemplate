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
    
    // What node are we on?
    @State var currentNodeId: Int = 1
    
    // What is the opacity of the text being shown?
    @State var textOpacity = 1.0
    
    // How many nodes have been visited?
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) AS VisitedNodeCount FROM Node WHERE Node.visits > 0")
    }) var nodesVisitedStats

    // How many nodes have been visited?
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) AS TotalNodeCount FROM Node")
    }) var totalNodesStats
    
    // The actual integer value for how many nodes have been visited
    var visitedNodes: Int {
        return nodesVisitedStats.results.first?["VisitedNodeCount"]?.intValue ?? 0
    }

    // The actual integer value for how many nodes have been visited
    var totalNodes: Int {
        return totalNodesStats.results.first?["TotalNodeCount"]?.intValue ?? 0
    }
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
            
            Text("A total of \(visitedNodes) nodes out of \(totalNodes) nodes overall have been visited in this story.")
                .opacity(textOpacity)

            Divider()
            
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                    .opacity(textOpacity)
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
            
            Divider()
            
            
            EdgesView(currentNodeId: $currentNodeId, textOpacity: $textOpacity)
                        
            Spacer()
            
        }
        .opacity(textOpacity)
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
