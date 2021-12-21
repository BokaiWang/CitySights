//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-21.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}

