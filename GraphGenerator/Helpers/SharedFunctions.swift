//
//  SharedFunctions.swift
//  GraphGenerator
//
//  Created by Russell Gordon on 2023-06-10.
//

import Blackbird
import Foundation

// Function to generate output that Graphviz requires
func generateGraphvizCommands(using description: StoryInformation, usingDatabase db: Blackbird.Database) async -> String {
    
    // Opening of graph
    var output = "digraph \"[map]\" {\n"
    
    // Start subgraph which contains table that comprises title section
    output += "subgraph { \"title\" [shape=none label=<<table border=\"0\">\n"
    output += "  <tr>\n"
    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"40\"><b>\(description.title)</b></font></td>\n"
    output += "    <td width=\"100\"></td>\n"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\">By \(description.authorOrAuthors)</font></td>\n"
    output += "    <td></td>"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "    <td>&nbsp;</td>\n"
    output += "    <td></td>"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(description.seriesInfo)</font></td>\n"
    output += "    <td></td>"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "    <td align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(description.publisherInfo)</font></td>\n"
    output += "    <td></td>"
    output += "  </tr>\n"
    
    // End the table that comprises title section
    output += "</table>>]\n"
    output += "}\n"
    
    // Make empty dictionary to track endings
    var endingsCount = [String : Int]()
    
    // Build the graph itself from a sorted list of the nodes
    do {
        
        for node in try await db.query("SELECT * FROM Node ORDER BY Node.node_id ASC") {
            if let node_id = node["node_id"]?.intValue
            {
                
                // Handle ending nodes
                if let ending_type_id = node["ending_type_id"]?.intValue {
                    
                    do {
                        for ending in try await db.query("SELECT * FROM EndingType WHERE id = \(ending_type_id)") {
                            
                            if let ending_type = ending["type"]?.stringValue,
                               let ending_color = ending["color"]?.stringValue
                            {
                                
                                // Make ending nodes show up in red
                                output += "\(node_id) [style=\"filled\", fillcolor=\"\(ending_color)\"]\n"
                                
                                // Get the ending description, if it exists
                                let ending_description = node["ending_narrative"]?.stringValue ?? ""
                                
                                // Create an invisible node after each ending node
                                output += "\"\(ending_description) \(node_id)\" [style=invis]\n"
                                
                                // Make a label after the ending node
                                output += "\(node_id) -> \"\(ending_description) \(node_id)\" [labelangle=0, minlen=3,  color=white, taillabel=\"\\n\(ending_description)\", fontname=\"Helvetica Bold\"]\n"
                                
                                // Track endings by category
                                if let valueForKey = endingsCount[ending_type] {
                                    // Increment count of endings of this type
                                    endingsCount[ending_type]! = valueForKey + 1
                                } else {
                                    // Start count of endings of this type
                                    endingsCount[ending_type] = 1
                                }
                            }
                            
                        }
                    } catch {
                        print("===")
                        print("Could not access EndingType table in database when using ending type ID of \(ending_type_id).")
                        print(error.localizedDescription)
                        
                    }
                    
                }
                
                // Draw nodes and edges between nodes
                output += "\(node_id) -> {"
                do {
                    for edge in try await db.query("SELECT * FROM Edge WHERE from_node_id = \(node_id)") {
                        if let destination_node_id = edge["to_node_id"]?.intValue {
                            output += "\(destination_node_id);"
                        }
                    }
                } catch {
                    print("===")
                    print("Could not access Edge table in database when using node ID of \(node_id).")
                    print(error.localizedDescription)
                }
                output += "} [minlen=2]\n"

            }
        }
        
    } catch {
        print("===")
        print("Could not access Node table in database.")
        print(error.localizedDescription)
    }
    
    // Start subgraph which endings analysis
    output += "subgraph { \"endings\" [shape=none label=<<table border=\"0\">\n"
    output += "  <tr>\n"
    output += "  <td width=\"100\"></td>\n"
    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>&nbsp;</b></font></td>\n"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "  <td></td>\n"
    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>&nbsp;</b></font></td>\n"
    output += "  </tr>\n"
    output += "  <tr>\n"
    output += "  <td></td>\n"
    output += "    <td colspan=\"2\" align=\"left\"><font face=\"Verdana,Helvetica\" point-size=\"20\"><b>Analysis of endings</b></font></td>\n"
    output += "  </tr>\n"
    
    // Make placeholders for counts of ending types
    do {
        for ending in try await db.query("SELECT * FROM EndingType") {
    
            if let ending_type = ending["type"]?.stringValue,
               let ending_color = ending["color"]?.stringValue
            {

                // Get count of endings for this ending type
                var countForThisEndingType = 0
                if let count = endingsCount[ending_type] {
                    countForThisEndingType = count
                }
                
                output += "  <tr>\n"
                output += "  <td></td>\n"
                output += "<td align=\"right\" valign=\"top\"><font face=\"Verdana,Helvetica\" point-size=\"16\">\(countForThisEndingType)</font></td>"
                output += "    <td align=\"left\" valign=\"bottom\"><font face=\"Verdana,Helvetica\" point-size=\"18\" color=\"\(ending_color)\"><b>\(ending_type)</b></font></td>\n"
                output += "  </tr>\n"

            }

        }
    } catch {
        print("===")
        print("Could not access EndingType table in database.")
        print(error.localizedDescription)
    }
        
    // End the table that comprises title section
    output += "</table>>]\n"
    output += "}\n"
    
    // Close out the graph
    output += "}\n"
    
    return output
    
}

