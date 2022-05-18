//
//  GetHistoryModel.swift
//  toBanto
//
//  Created by Irianda on 10/12/21.
//

import Foundation

struct GetHistoryModel: Codable {
    let data : [DataTableHistory]
}

struct DataTableHistory:Codable {
    var id : Int!
    var totalDonate: Int!
    let project : dataDetailCampaign!
}





