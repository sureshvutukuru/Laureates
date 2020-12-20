//
//  LaureateModel.swift
//  Laureates
//
//  Created by Suresh Vutukuru on 18/12/20.
//  Copyright © 2020 Suresh Vutukuru. All rights reserved.
//

import Foundation

struct Laureate: Decodable {
//    let born: String
//    let borncity: String
//    let borncountry: String
    let category: String
//    let city: String
    let country: String
//    let died: String
//    let diedcity: String
//    let diedcountry: String
    let firstname: String
//    let gender: String
    let id: Int
    let location: Location
    let motivation: String
    let name: String
    let surname: String
    let year: String
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}
