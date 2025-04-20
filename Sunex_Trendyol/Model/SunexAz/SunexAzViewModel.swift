//
//  SunexAzViewModel.swift
//  Sunex_Trendyol
//
//  Created by User on 19.04.25.
//

import Foundation

protocol SunexAzViewModelDelegate {
    func render(_ state: SunexAzViewModel.State)
}

class SunexAzViewModel {
    enum State {
        case loading
        case loaded([SunexAzModel.Notification])
        case reset
        case error(Error)
    }
    
    private let networkService: URLSeassionsAdapter = URLSeassionsAdapter()
    private var delegate: SunexAzViewModelDelegate?
    private var request: SunexAzModel.Request = .init(token: "some_token")
    private var isFetchNextCalled: Bool = false
    private var hasNext: Bool = true
    
    func fetchNews() {
        delegate?.render(.loading)
        networkService.fetchNews(with: request) { result in
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
        networkService.fetchNews(with: request) { result in
            switch result {
            case .success(let data):
                print("Data:", data)
                let uiModel = self.mapToUiModel(data)
                self.delegate?.render(.loaded(uiModel))
                self.isFetchNextCalled = false
                self.hasNext = !data.data.notificationList.isEmpty
            case .failure(let error):
                print("Error:", error)
                self.isFetchNextCalled = false
                self.delegate?.render(.error(error))
            }
        }
    }
    func subscribe(_ delegate: SunexAzViewModelDelegate) {
        self.delegate = delegate
    }
    
    private func mapToUiModel(_ data: SunexAzModel.Response) -> [SunexAzModel.Notification] {
        return data.data.notificationList
    }
}
