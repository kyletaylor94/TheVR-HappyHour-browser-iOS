import Moya
import Foundation

// MARK: - HappyHourAPI
enum HappyHourAPI {
    case loadPage(targetPage: Int)
    case spotifyAuthentication(clientID: String, clientSecret: String)
    case searchSpotifyEpisodes(query: String, type: String, limit: Int, offset: Int, accessToken: String?)
}

extension HappyHourAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .loadPage:
            return URL(string: "https://thevr.hu/thevrapps/HappyHour/ajax.hhvideos.php")!
        case .spotifyAuthentication:
            return URL(string: "https://accounts.spotify.com")!
        case .searchSpotifyEpisodes:
            return URL(string: "https://api.spotify.com")!
        }
    }
    
    var path: String {
        switch self {
            
        case .loadPage:
            return ""
            
        case .spotifyAuthentication:
            return "/api/token"
            
        case .searchSpotifyEpisodes:
            return "v1/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadPage, .spotifyAuthentication:
            return .post
            
        case .searchSpotifyEpisodes:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loadPage(let targetPage):
            let parameters = ["srcTag": "", "page": "\(targetPage)"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
            
        case .spotifyAuthentication:
            let parameters = ["grant_type": "client_credentials"]
            return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: URLEncoding.httpBody, urlParameters: [:])
            
        
        case .searchSpotifyEpisodes(let query, let type, let limit, let offset, _):
            let parameters: [String: Any] = [
                "q": query,
                "type": type,
                "limit": limit,
                "offset": offset
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .loadPage:
            return ["Content-Type": "application/x-www-form-urlencoded"]
            
        case .spotifyAuthentication(let clientID, let clientSecret):
            let credentials = "\(clientID):\(clientSecret)".data(using: .utf8)?.base64EncodedString() ?? ""
            return [
                "Authorization": "Basic \(credentials)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            
        case .searchSpotifyEpisodes(_,_,_,_, let accessToken):
            guard let token = accessToken else {
                print("no access token available")
                return nil
            }
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
