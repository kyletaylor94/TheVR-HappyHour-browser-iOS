//
//  SpotifyApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 18..
//

import Foundation
import Moya

protocol SpotifyApiService {
    func spotifyAuthentication() async throws -> SpotifyTokenResponse?
    func searchSpotifyEpisodes(query: String, type: String,limit: Int, offset: Int, accessToken: String?) async throws -> SpotifySearchResponse
}

class SpotifyApiServiceImpl: SpotifyApiService {
    
    private let provider = MoyaProvider<HappyHourAPI>()
    
    private let cliendID = ""
    private let clientSecret = ""
    
    func spotifyAuthentication() async throws -> SpotifyTokenResponse? {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.spotifyAuthentication(clientID: cliendID, clientSecret: clientSecret)) { result in
                switch result {
                case .success(let response):
                    if let tokenResponse = try? JSONDecoder().decode(SpotifyTokenResponse.self, from: response.data) {
                        print("SPOTIFYSTATUSCODE: \(response.statusCode)")
                        continuation.resume(returning: tokenResponse)
                    } else {
                        print("DEBUG: Decoding error - SpotifyAuthentication")
                        continuation.resume(throwing: ApiError.decodingError)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: ApiError.spotifyAuthentication)
                }
            }
        }
    }
    
    func searchSpotifyEpisodes(query: String, type: String, limit: Int, offset: Int, accessToken: String?) async throws -> SpotifySearchResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.searchSpotifyEpisodes(query: query, type: type, limit: limit, offset: offset, accessToken: accessToken)) { result in
                switch result {
                case .success(let response):
                    do {
                        let episodeResponse = try JSONDecoder().decode(SpotifySearchResponse.self, from: response.data)
                        continuation.resume(returning: episodeResponse)
                    } catch {
                        print("DEBUG: Decoding Error- SearchSpotifyEpisodes \(String(describing: error.localizedDescription))")
                        continuation.resume(throwing: ApiError.decodingError)
                    }
                case .failure(let error):
                    print("DEBUG: Request error: \(error.localizedDescription)")
                    continuation.resume(throwing: ApiError.unknown(error))
                }
            }
        }
    }
}
