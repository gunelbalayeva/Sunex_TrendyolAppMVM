//
//  TrendyOlModel.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

struct TrendyOlModel {
    struct Request: Codable {
        let token: String
    }
    struct Notification: Codable {
        let title: String
        let message: String
        let createdAt: String
        let isRead: Bool
    }
    
    struct NotificationData: Codable {
        let trendyolList: [Notification]
    }
    
    struct Response: Codable {
        let data: NotificationData
    }
}
