//
//  NewLocationDelegate.swift
//  HappyPlaces
//
//  Created by Roman on 5/9/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

protocol NewLocationDelegate
{
    func newLocationAdded(name: String, lat: Double, long: Double)
}
