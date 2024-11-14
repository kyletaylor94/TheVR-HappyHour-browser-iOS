//
//  SpotifyViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 26..
//

import Foundation

@MainActor
class SpotifyViewModel: ObservableObject {
 
    //TODO: Clean code for the Spotify: Repository - Interactor - ViewModel
    //TODO: Bug - Episode 1714 is missing from the TheVR site, but on the spotify it is exist.
    //TODO: Bug - After install app - no data content available, if I close and reopen the app, apicall works fine.
    
    @Published var episodes: [SpotifyEpisode] = []
    @Published var hasMorePages: Bool = true
    
    private var offset = 0
    private let limit: Int = 8
    private var spotifyToken: String? = ""
    
    private var interactor: SpotifyInteractor {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyInteractor.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyInteractor.self)")
        }
        return container
    }
    
    func spotifyAuthentication() async {
        do {
            self.spotifyToken = try await self.interactor.fetchSpotifyTokenFromRepo()
        } catch {
            print("DEBUG: SpotifyAuthentication Failed! - \(error.localizedDescription)")
        }
    }
    
    func fetchSpotifyEpisodes(viewModel: HappyHourViewModel) async {
        guard hasMorePages else { return }
        guard let spotifyToken else { return }
        
        do {
            let newEpisodes = try await interactor.fetchSpotifyEpisodesFromRepo(offset: offset, limit: limit, spotifyToken: spotifyToken)
            
            if viewModel.allVideos.isEmpty || viewModel.allVideos.count < limit {
                hasMorePages = false
            } else {
                offset += limit
            }
            self.episodes.append(contentsOf: newEpisodes)
        } catch {
            print("DEBUG: Cannot fetch Spotify episodes: \(error.localizedDescription)")
        }
    }
    
    func loadNextPageOnSpotify(viewModel: HappyHourViewModel) async {
        await fetchSpotifyEpisodes(viewModel: viewModel)
    }
    

    func updateSpotifyUrls(viewModel: HappyHourViewModel) async {
        for (index, episode) in episodes.enumerated() {
            if index < viewModel.allVideos.count {
                print("THIS IS: \(viewModel.allVideos[index])")
                //  print("ALLVIDEO count: \(allVideos.count) : SpotifyIndex: \(index)")
                viewModel.allVideos[index].spotifyUrl = episode.external_urls
            }
        }
    }
}
