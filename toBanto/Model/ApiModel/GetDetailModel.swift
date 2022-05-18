//
//  GetDetailModel.swift
//  toBanto
//
//  Created by Irianda on 15/12/21.
//

import Foundation

struct GetDetailModel:Codable {
    let data : [dataDetailCampaign]
}

struct dataDetailCampaign:Codable {
    var id : Int!
    var projectImg : String!
    var projectName : String!
    var duration :Int!
    var donateAll : Int!
    var totalDonate: Int!
    var profilePeneliti : String!
    var projectSummary : String!
    var budgetDetails : String!
    var projectBackground :String!
    var projectGoal : String!
    var budget : String!
    var category: String!
}
