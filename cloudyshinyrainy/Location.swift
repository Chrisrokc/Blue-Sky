//
//  Location.swift
//  cloudyshinyrainy
//
//  Created by Christopher Rogers on 11/3/16.
//  Copyright © 2016 Rogers. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
    
}
