//
//  DirectedGraphBuilder.swift
//  GraphGenerator
//
//  Created by Russell Gordon on 2023-06-10.
//

import Foundation
import Cocoa
import Blackbird

// NOTE: This is the command-line app entry point
@main
struct DirectedGraphBuilder {
    
    static func main() async throws {


        // Attempt to open the database
        let db = AppDatabase.instance

        // TODO: 1 - Replace details of this instance of StoryInformation with data for your own group's story
        let storyInfo = StoryInformation(title: "Journey Under The Sea",
                                         authorOrAuthors: "R.A. Montgomery",
                                         seriesInfo: "CHOOSE YOUR OWN ADVENTURE #2",
                                         publisherInfo: "Chooseco LLC, Waitsfield, Vermont, 2006")

        print("About to read node and edge data from database...", terminator: "")
        let graphVizCommands = await generateGraphvizCommands(using: storyInfo, usingDatabase: db)
        print("done.")

        // Copy to the clipboard
        print("About to add to clipboard...", terminator: "")
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(graphVizCommands, forType: .string)
        print("done.")


        // TODO: 2 - If you have not yet, install Homebrew.
        //
        //       https://brew.sh

        // TODO: 3 - If you have not yet, install graphviz by running this command in the Terminal
        //
        //       brew install graphviz

        // TODO: 4 - In the Terminal, from the folder 'input.txt' exists in, run the following command to generate your group's graph:
        //
        //           dot -Tpdf input.txt > output.pdf

        
    }
    
}

