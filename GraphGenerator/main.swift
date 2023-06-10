//
//  main.swift
//  GraphGenerator
//
//  Created by Russell Gordon on 2023-06-10.
//

import Foundation
import Blackbird

// Attempt to open the database
let db = AppDatabase.instance

print("=== DATABASE DUMP BEGINS ===")
for node in try await db.query("SELECT * FROM Node") {
    if let node_id = node["node_id"]?.intValue,
       let narrative = node["narrative"]?.stringValue {
        
        print(node_id)
        print(narrative)
        print("-----")
    }
    
}
print("=== DATABASE DUMP ENDS ===")


//// Function to generate output that Graphviz requires
//func generateGraphvizCommands(using description: StoryInformation, with nodes: [Int : Node]) -> String {
//
//    // Opening of graph
//    var output = "digraph \"[map]\" {\n"
//
//    // Start subgraph which contains table that comprises title section
//    output += "subgraph { \"title\" [shape=none label=<<table border=\"0\">\n"
//    output += "  <tr>\n"
//    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"40\"><b>\(description.title)</b></font></td>\n"
//    output += "    <td width=\"100\"></td>\n"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\">By \(description.authorOrAuthors)</font></td>\n"
//    output += "    <td></td>"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "    <td>&nbsp;</td>\n"
//    output += "    <td></td>"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(description.seriesInfo)</font></td>\n"
//    output += "    <td></td>"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(description.publisherInfo)</font></td>\n"
//    output += "    <td></td>"
//    output += "  </tr>\n"
//
//    // End the table that comprises title section
//    output += "</table>>]\n"
//    output += "}\n"
//
//    // Make empty dictionary to track endings
//    var endingsCount = [String : Int]()
//
//    // Build the graph itself from a sorted list of the nodes
//    for (key, node) in nodes.sorted(by: { lhs, rhs in lhs.key < rhs.key }) {
//
//        // Handle ending nodes
//        if let ending = node.ending {
//
//            // Make ending nodes show up in red
//            output += "\(key) [style=\"filled\", fillcolor=\"\(ending.color)\"]\n"
//
//            // Create an invisible node after each ending node
//            output += "\"\(ending.description) \(node.id)\" [style=invis]\n"
//
//            // Make a label after the ending node
//            output += "\(key) -> \"\(ending.description) \(node.id)\" [labelangle=0, minlen=3,  color=white, taillabel=\"\\n\(ending.description)\", fontname=\"Helvetica Bold\"]\n"
//
//            // Track endings by category
//            if let valueForKey = endingsCount[ending.classification.rawValue] {
//                // Increment count of endings of this type
//                endingsCount[ending.classification.rawValue]! = valueForKey + 1
//            } else {
//                // Start count of endings of this type
//                endingsCount[ending.classification.rawValue] = 1
//            }
//        }
//
//        // Draw nodes and edges between nodes
//        output += "\(key) -> {"
//        for edge in node.edges {
//            output += "\(edge.destinationId);"
//        }
//        output += "} [minlen=2]\n"
//    }
//
//    // Start subgraph which endings analysis
//    output += "subgraph { \"endings\" [shape=none label=<<table border=\"0\">\n"
//    output += "  <tr>\n"
//    output += "  <td width=\"100\"></td>\n"
//    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>&nbsp;</b></font></td>\n"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "  <td></td>\n"
//    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>&nbsp;</b></font></td>\n"
//    output += "  </tr>\n"
//    output += "  <tr>\n"
//    output += "  <td></td>\n"
//    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>Analysis of endings</b></font></td>\n"
//    output += "  </tr>\n"
//
//    // Make placeholders for counts of ending types
//    for enumerationCase in EndingClassification.allCases {
//
//        // Get count of endings for this ending type
//        var countForThisEndingType = 0
//        if let count = endingsCount[enumerationCase.rawValue] {
//            countForThisEndingType = count
//        }
//
//        output += "  <tr>\n"
//        output += "  <td></td>\n"
//        output += "<td align=\"right\" valign=\"top\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(countForThisEndingType)</font></td>"
//        output += "    <td align=\"left\" valign=\"bottom\"><font face=\"Verdana,Helvetica\" point-size=\"18\" color=\"\(Ending.init(classification: enumerationCase, description: "").color)\"><b>\(enumerationCase.rawValue)</b></font></td>\n"
//        output += "  </tr>\n"
//    }
//
//    // End the table that comprises title section
//    output += "</table>>]\n"
//    output += "}\n"
//
//    // Close out the graph
//    output += "}\n"
//
//    return output
//
//}


// Track information about story
struct StoryInformation {
    let title: String
    let authorOrAuthors: String
    let seriesInfo: String
    let publisherInfo: String
}

// TODO: Replace details of this instance of StoryInformation with data for your own group's story
let storyInfo = StoryInformation(title: "Journey Under The Sea",
                                 authorOrAuthors: "R.A. Montgomery",
                                 seriesInfo: "CHOOSE YOUR OWN ADVENTURE #2",
                                 publisherInfo: "Chooseco LLC, Waitsfield, Vermont, 2006")


//let graphVizCommands = generateGraphvizCommands(using: storyInfo,
//                                                with: storyNodes)

// Copy to the clipboard
//let pasteBoard = NSPasteboard.general
//pasteBoard.clearContents()
//pasteBoard.setString(graphVizCommands, forType: .string)

// TODO: 6 - Paste the output from this program into a BBEdit text document named 'input.txt'.

// TODO: 7 - If you have not yet, install Homebrew.
//
//       https://brew.sh

// TODO: 8 - If you have not yet, install graphviz by running this command in the Terminal
//
//       brew install graphviz

// TODO: 9 - In the Terminal, from the folder 'input.txt' exists in, run the following command to generate your group's graph:
//
//           dot -Tpdf input.txt > output.pdf
