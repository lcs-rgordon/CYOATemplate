//
//  NodeView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import Blackbird
import SwiftUI

struct NodeView: View {
    
    // MARK: Stored properties
    
    // The id of the node we are trying to view
    let nodeId: Int

    // Needed to query database
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // The list of nodes retrieved
    @BlackbirdLiveModels var nodes: Blackbird.LiveResults<Node>
    
    // MARK: Computed properties
    
    // The user interface
    var body: some View {
        if let node = nodes.results.first {
            Text(try! AttributedString(markdown: node.narrative))
        } else {
            Text("Node with id \(nodeId) not found; directed graph has a gap.")
        }
    }
    
    // MARK: Initializer
    init(forNodeWithId id: Int) {
        
        // Retrieve rows that describe nodes in the directed graph
        // NOTE: There should only be one row for a given node_id
        //       since there is a UNIQUE constrant on the node_id column
        //       in the Node table
        _nodes = BlackbirdLiveModels({ db in
            try await Node.read(from: db,
                                    sqlWhere: "node_id = ?", "\(id)")
        })
        
        // Set the node we are trying to view
        nodeId = id
        
    }

    
}

struct NodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NodeView(forNodeWithId: 1)
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
