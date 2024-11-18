//
//  ApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation
import Moya

class HappyHourApiServiceImpl: HappyHourApiService {
    
    private let provider = MoyaProvider<HappyHourAPI>()
    
    func getLoadHappyHourPage(targetPage: Int) async throws -> HappyHourPageModel {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.loadPage(targetPage: targetPage)) { result in
                switch result {
                case .success(let response):
                    do {
                        let page = try JSONDecoder().decode(HappyHourPageModel.self, from: response.data)
                        print("HappyhourSite statuscode: \(response.statusCode)")
                        continuation.resume(returning: page)
                    } catch {
                        print("DEBUG: Decoding error - HappyHourPage")
                        continuation.resume(throwing: ApiError.decodingError)
                    }
                case .failure(let error):
                    print("DEBUG: HappyHourPage - Request error: \(error.localizedDescription)")
                    continuation.resume(throwing: ApiError.unknown(error))
                }
            }
        }
    }
}
