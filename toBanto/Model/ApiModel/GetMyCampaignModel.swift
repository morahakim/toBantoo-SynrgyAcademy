//
//  GetMyCampaignModel.swift
//  toBanto
//
//  Created by Irianda on 10/12/21.
//

import Foundation

struct GetMyCampaignModel:Decodable {
    let data : [DataMyCampaign]
}

struct DataMyCampaign: Decodable {
      var id : Int!
      var projectName: String!
      var category: String!
      var duration: Int!
      var projectEnd: String!
      var budget: String!
      var projectImg: String!
}
