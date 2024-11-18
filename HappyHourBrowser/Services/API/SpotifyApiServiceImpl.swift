//
//  SpotifyApiServiceImpl.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 18..
//

import Foundation
import Moya

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
    
    func fetchSpotifyEpisodes(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode] {
        guard let token = accessToken else {
            print("DEBUG: SpotifyEpisodes - No access token available.")
            return []
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.fetchSpotifyEpisodes(showID: showID, offset: offset, limit: limit, accessToken: token)) { result in
                switch result {
                case .success(let response):
                    do {
                        let episodeResponse = try JSONDecoder().decode(SpotifyEpisodesResponse.self, from: response.data)
                        continuation.resume(returning: episodeResponse.items)
                    } catch {
                        print("DEBUG:Decoding error - FetchSpotifyEpisode!")
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
