//
//  APIService.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

protocol APIService {
    func fetchNews(with request: SunexAzModel.Request, completion: @escaping (Result<SunexAzModel.Response, Error>) -> Void)
}
