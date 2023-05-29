//
//  Node.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

struct Node: Identifiable {
    let id: Int
    let paragraphs: [String]
    let image: String?
    let edges: [Edge]
    let ending: Ending?
}

// A single node
let testNode = Node(id: 1,
                    paragraphs: [
                        "You are a deep sea explorer searching for the famed lost city of Atlantis. This is your most challenging and dangerous mission. Fear and excitement are now your companions.",
                        
                        "It is morning and the sun pushes up on the horizon. The sea is calm. You climb into the narrow pilot's compartment of the underwater vessel *Seeker* with your special gear. The crew of the research vessel *Maray* screws down the hatch clamps. Now begins the plunge into the depths of the ocean. The *Seeker* crew begins lowering by a strong, but thin, cable. Within minutes, you are so deep in the ocean that little light filters down to you. The silence is eerie as the *Seeker* slips deeper and deeper. You peer out the thick glass porthole and see strange white fish drifting past, sometimes stopping to look at you–an intruder from another world.",
                        
                    ],
                    image: "node-1",
                    edges: [
                        Edge(destinationId: 2,
                             prompt: "*Turn to the next page*")
                        ,
                    ],
                    ending: nil)

let emptyNode = Node(id: 0, paragraphs: [""], image: nil, edges: [], ending: nil)

// An array of nodes that model the narrative's directed graph
let storyNodes: [Node] = [
    
    testNode
    
    ,
    
    Node(id: 2,
         paragraphs: [
            "The cable attaching you to the *Maray* is extended to its limit. You have come to rest on a ledge near the canyon in the ocean floor that ancient myth says leads to the lost city of Atlantis.",
            
            "You have an experimental diving suit designed to protect you from the intense pressure of the deep. You should be able to leave the *Seeker* and explore the sea bottom. The new suit contains a number of the latest microprocessors enabling a variety of useful functions. It even has a built-in waterproof smart tablet with laser communicator. You can cut loose from the cable; the *Seeker* is self-propelled. You are now in another world. Remember, this is a dangerous world, an unknown world.",
            
            "As agreed, you signal the *Maray*, \"All systems GO. It's awesome down here.\"",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 4,
                 prompt: "*If you decide to cut loose from the* Maray *and dive with the* Seeker *into the canyon in the ocean floor, turn to page 4.*")
            ,
            Edge(destinationId: 6, prompt: "*If you decide to explore the ledge where the* Seeker *has come to rest, turn to page 6.*")
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 3,
         paragraphs: [
            
            "Carefully maneuvering the *Seeker* between the walls of the canyon, you discover a large round hole. A stream of large bubbles flows steadily out of the hole. The *Seeker* is equipped with scientific equipment to analyze the bubbles. It also has sonar equipment that can measure depth. The ocean covers close to 90% of the earth and is mostly unknown. Who knows where this hole might lead?",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 9,
                 prompt: "*If you decide to analyze the bubbles, turn to page 9.*")
            ,
            Edge(destinationId: 14,
                 prompt: "*If you decide to take depth readings, turn to page 14.*")
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 4,
         paragraphs: [
            
            "The *Maray* asks you for a more detailed status report, and you comply, telling them that you are going to cast off from the line and descend under your own power.",
            
            "Approval is given, and the *Seeker* slips silently into the undersea canyon.",
            
            "As you drop into the canyon, you turn on the *Seeker*'s searchlight. Straight ahead is a dark wall covered with a strange type of barnacle growth. To the left (port) side, you see what appears to be a grotto. The entrance is perfectly round, as if it had been cut by human hands.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 5,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    ,
    
    Node(id: 5,
         paragraphs: [
            
            "White lantern fish give off a pale, greenish light. To the right (starboard) side of the *Seeker*, you see bubbles rising steadily from the floor of the canyon.",
            
         ],
         image: "node-4",
         edges: [
            
            Edge(destinationId: 3,
                 prompt: "*If you decide to investigate the bubbles, turn to page 3.*")
            
            ,
            
            Edge(destinationId: 8,
                 prompt: "*If you decide to investigate the grotto with the round entrance, turn to page 8.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 6,
         paragraphs: [
            
            "Your dive suit is a tight fit and takes you some time to put it on. Finally, you slip from the airlock of the *Seeker* and stand on the ocean floor. It is a strange and marvelous world where your every move is slowed down. You begin the exploration with your halogen searchlight. The ledge hanging over the deep canyon is your starting point.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 7,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
]
