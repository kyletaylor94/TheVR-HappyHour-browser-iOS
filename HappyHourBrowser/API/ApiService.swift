//
//  ApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation
import Moya
import Combine
import CombineMoya

class ApiService {
    static let shared = ApiService()
    private let provider = MoyaProvider<HappyHourAPI>()
    
    func loadHappyHourPage(targetPage: Int) async ->AnyPublisher<HappyHourPageModel, ApiError> {
        provider.requestPublisher(.loadPage(targetPage: targetPage))
            .map(HappyHourPageModel.self)
            .mapError { error in
                ApiError.moyaError(error)
            }
            .eraseToAnyPublisher()
    }
    
    func searchEpisodes(searchType: SearchOption, query: String, targetPage: Int) async -> AnyPublisher<[HappyHourVideoModel], ApiError> {
        provider.requestPublisher(.searchEpisodes(searchType: searchType, query: query, targetPage: targetPage))
            .map(HappyHourPageModel.self)
            .map { $0.hhVideos }
            .mapError { error in
                ApiError.moyaError(error)
            }
            .eraseToAnyPublisher()
    }
}
