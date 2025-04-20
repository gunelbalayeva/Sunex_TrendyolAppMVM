//
//  SunexAzModel.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

class SunexAzModel {
    struct Notification: Codable {
        let title: String
        let message: String
        let createdAt: String
        let isRead: Bool
    }
    struct NotificationData: Codable {
        let notificationList: [Notification]
    }
    
    struct Response: Codable {
        let data: NotificationData
    }
    
    struct  Request: Codable {
        let token: String
    }
    
}
