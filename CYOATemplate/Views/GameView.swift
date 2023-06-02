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
    
    // The total number of nodes that have been visited at least once
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) as VisitedNodeCount FROM Node WHERE Node.visits > 0")
    }) var nodesVisitedStats

    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) as TotalNodeCount FROM Node")
    }) var totalNodesStats
    
    var visitedNodes: Int {
        return nodesVisitedStats.results.first?["VisitedNodeCount"]?.intValue ?? 0
    }
    
    var totalNodes: Int {
        return totalNodesStats.results.first?["TotalNodeCount"]?.intValue ?? 0
    }
    
    // MARK: Computed properties
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("A total of \(visitedNodes) nodes out of \(totalNodes) have been visited in this story.")
            
            Divider()
            
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                Spacer()
            }
            
            NodeView(currentNodeId: $currentNodeId)
            
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
