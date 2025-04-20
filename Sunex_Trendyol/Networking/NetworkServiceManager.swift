//
//  NetworkServiceManager.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation
import UIKit
class NetworkServiceManager {
    static let shared = NetworkServiceManager(service: URLSeassionsAdapter())
    
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func fetchSunexAz(with request: SunexAzModel.Request, completion: @escaping (Result<SunexAzModel.Response, Error>) -> Void) {
        service.fetchNews(with: request, completion: completion)
    }
}
