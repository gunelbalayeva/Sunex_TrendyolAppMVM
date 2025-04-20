//
//  TrendyOlViewModel.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

protocol TrendyolViewModelDelegate {
    func render(_ state: TrendyolViewModel.State)
}

class TrendyolViewModel {
    
    enum State {
        case loading
        case loaded([TrendyOlModel.Notification])
        case reset
        case error(Error)
    }
    
    private let networkService: URLSeassionsAdapter = URLSeassionsAdapter()
    private var delegate: TrendyolViewModelDelegate?
    private var request: TrendyOlModel.Request = .init(token: "some_token")
    private var isFetchNextCalled: Bool = false
    private var hasNext: Bool = true
    
    func subscribe(_ delegate: TrendyolViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchNews() {
        delegate?.render(.loading)
        networkService.fetchTrendyolNews(with: request) { result in
            switch result {
            case .success(let data):
                print("Data:", data)
                let uiModel = self.mapToUiModel(data)
                self.delegate?.render(.reset)
                self.delegate?.render(.loaded(uiModel))
            case .failure(let error):
                print("Error:", error)
                self.delegate?.render(.error(error))
            }
        }
    }
    
    func fetchNextNews() {
        guard !isFetchNextCalled, hasNext else { return }
        isFetchNextCalled = true
        delegate?.render(.loading)
        networkService.fetchTrendyolNews(with: request) { result in
            switch result {
            case .success(let data):
                print("Data:", data)
                let uiModel = self.mapToUiModel(data)
                self.delegate?.render(.loaded(uiModel))
                self.isFetchNextCalled = false
                self.hasNext = !data.data.trendyolList.isEmpty
            case .failure(let error):
                print("Error:", error)
                self.isFetchNextCalled = false
                self.delegate?.render(.error(error))
            }
        }
    }
    
    private func mapToUiModel(_ data: TrendyOlModel.Response) -> [TrendyOlModel.Notification] {
        return data.data.trendyolList
    }
}
