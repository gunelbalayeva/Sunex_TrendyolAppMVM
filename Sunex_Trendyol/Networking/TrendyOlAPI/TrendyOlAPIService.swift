//
//  TrendyOlAPIService.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

protocol TrendyOlAPIService {
    
func fetchTrendyolNews(with request: TrendyOlModel.Request, completion: @escaping (Result<TrendyOlModel.Response, Error>) -> Void)
}
