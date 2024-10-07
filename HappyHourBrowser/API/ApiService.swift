//
//  ApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    private let baseUrl = "https://thevr.hu/thevrapps/HappyHour/ajax.hhvideos.php"
    
    func loadHappyHourPage(targetPage: Int) async throws -> HappyHourPageModel {
        guard let url = URL(string: baseUrl) else { throw ApiError.badUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // FormData parameters
        let parameters = "srcTag=&page=\(targetPage)"
        request.httpBody = parameters.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse(statusCode: 0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            throw ApiError.noData
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(HappyHourPageModel.self, from: data)
            return result
        } catch {
            throw ApiError.decodingError
        }
    }
    
    func searchEpisodes(searchType: SearchOption, query: String, targetPage: Int) async throws -> [HappyHourVideoModel]? {
        guard let url = URL(string: baseUrl) else { throw ApiError.badUrl }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parameters: String
        
        switch searchType {
        case .byPart:
            parameters = "srcTag=&part=\(query)&page=\(targetPage)"
        case .byDate:
            parameters = "srcTag=&date=\(query)&page=\(targetPage)"
        case .byText:
            parameters = "srcTag=\(query)&page=\(targetPage)"
        }
        
        request.httpBody = parameters.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse(statusCode: 0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            throw ApiError.noData
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(HappyHourPageModel.self, from: data)
            return result.hhVideos
        } catch {
            throw ApiError.decodingError
        }
    }
}
