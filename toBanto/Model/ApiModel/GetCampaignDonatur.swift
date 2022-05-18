//
//  GetCampaignDonatur.swift
//  toBanto
//
//  Created by Irianda on 13/12/21.
//

import Foundation

struct GetCampaignDonatur:Codable {
    let data : [DataTableDonatur]
}

struct DataTableDonatur:Codable {
    var id : Int!
    var projectName: String!
    var category: String!
    var duration: Int!
    var projectEnd: String!
    var budget: String!
    var projectImg: String!
}
