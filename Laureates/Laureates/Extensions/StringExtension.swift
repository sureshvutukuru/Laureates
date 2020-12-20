//
//  StringExtension.swift
//  Laureates
//
//  Created by Suresh Vutukuru on 19/12/20.
//  Copyright © 2020 Suresh Vutukuru. All rights reserved.
//

import Foundation

extension String {

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
    
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
