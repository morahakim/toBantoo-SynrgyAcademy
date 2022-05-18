//
//  GetCampaignModel.swift
//  toBanto
//
//  Created by Irianda on 07/12/21.
//

import Foundation

struct GetCampaignHome:Decodable {
    let data : [DataTableCampaign]
}

struct DataTableCampaign: Decodable {
      var id : Int!
      var projectName: String!
      var category: String!
      var duration: Int!
      var projectEnd: String!
      var budget: String!
      var projectImg: String!
}

