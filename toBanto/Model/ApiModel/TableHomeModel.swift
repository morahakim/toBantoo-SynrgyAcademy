//
//  TableHomeModel.swift
//  toBanto
//
//  Created by mora hakim on 06/12/21.
//

import Foundation
struct TableHomeModel: Codable {
    let data : [DataTable]
}

struct DataTable: Codable {
    var projectName: String!
    var catgory: String!
    var duration: String!
    
}
