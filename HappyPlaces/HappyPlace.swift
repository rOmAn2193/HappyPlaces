//
//  HappyPlace.swift
//  HappyPlaces
//
//  Created by Roman on 5/8/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import Foundation

class HappyPlace
{
    var name: String
    let lat: Double
    let long: Double

    init(name: String, lat: Double, long: Double)
    {
        self.name = name
        self.lat = lat
        self.long = long
    }
}