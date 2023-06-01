//
//  EdgesView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import Blackbird
import SwiftUI

struct EdgesView: View {
    
    // MARK: Stored properties
    
    // The id of the node we are trying to see the edges for
    let nodeId: Int

    // Needed to query database
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // The list of nodes retrieved
    @BlackbirdLiveModels var edges: Blackbird.LiveResults<Edge>
    
    // A derived value that points at the source of truth for the current node
    // on GameView
    @Binding var currentNode: Int
    
    // MARK: Computed properties
    
    // The user interface
    var body: some View {
        
        VStack(spacing: 20) {

            ForEach(edges.results) { currentEdge in

                HStack {
                    
                    Spacer()
                    
                    // Show a Text view, but render Markdown syntax, ignoring newlines
                    Text(try! AttributedString(markdown: currentEdge.prompt))
                        .multilineTextAlignment(.trailing)
                        .onTapGesture {
                            withAnimation {
                                currentNode = currentEdge.to_node_id
                            }
                        }

                }

            }

        }
        
    }
    
    // MARK: Initializer
    init(forNodeWithId id: Int, currentNode: Binding<Int>) {
        
        // Retrieve rows that describe nodes in the directed graph
        // NOTE: There should only be one row for a given node_id
        //       since there is a UNIQUE constrant on the node_id column
        //       in the Node table
        _edges = BlackbirdLiveModels({ db in
            try await Edge.read(from: db,
                                    sqlWhere: "from_node_id = ?", "\(id)")
        })
        
        // Set the node we are trying to view
        nodeId = id
        
        // Set the current node
        _currentNode = currentNode
        
    }
}

struct EdgesView_Previews: PreviewProvider {
    static var previews: some View {

        EdgesView(forNodeWithId: 1, currentNode: .constant(1))
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
        
    }
}
