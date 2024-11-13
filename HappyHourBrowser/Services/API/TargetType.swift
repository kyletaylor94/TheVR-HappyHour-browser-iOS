import Moya
import Foundation

// MARK: - HappyHourAPI
enum HappyHourAPI {
    case loadPage(targetPage: Int)
    case spotifyAuthentication(clientID: String, clientSecret: String)
    case fetchSpotifyEpisodes(showID: String, offset: Int, limit: Int, accessToken: String?)
}

extension HappyHourAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .loadPage:
            return URL(string: "https://thevr.hu/thevrapps/HappyHour/ajax.hhvideos.php")!
        case .spotifyAuthentication:
            return URL(string: "https://accounts.spotify.com")!
        case .fetchSpotifyEpisodes:
            return URL(string: "https://api.spotify.com")!
        }
    }
    
    var path: String {
        switch self {
        case .loadPage:
            return ""
        case .spotifyAuthentication:
            return "/api/token"
        case .fetchSpotifyEpisodes(let showID, _, _,_):
            return "/v1/shows/\(showID)/episodes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadPage, .spotifyAuthentication:
            return .post
        case .fetchSpotifyEpisodes:
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
            
        case .fetchSpotifyEpisodes(_, let offset, let limit, _):
            let parameters = ["offset": offset, "limit": limit]
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
            
        case .fetchSpotifyEpisodes(_,_,_,let accessToken):
            guard let token = accessToken else {
                print("No access token available.")
                return nil
            }
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
