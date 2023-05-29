//
//  Ending.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Foundation

struct Ending {
    let classification: EndingClassification
    let description: String
    var color: String {
        switch self.classification {
        case .great:
            return "#90C8E0"  // Light blue
        case .favorable:
            return "#FFDE5F"  // Pale yellow
        case .mediocre:
            return "#D7883C"  // Orange
        case .disappointing:
            return "#C1531E"  // Deep orange
        case .catastrophic:
            return "#AB1800"  // Deep red
        }
    }
}

