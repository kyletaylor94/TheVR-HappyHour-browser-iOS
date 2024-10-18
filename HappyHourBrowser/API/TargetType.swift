//
//  TargetType.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 18..
//

import Foundation
import Moya

enum HappyHourAPI {
    case loadPage(targetPage: Int)
    case searchEpisodes(searchType: SearchOption, query: String, targetPage: Int)
}

extension HappyHourAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://thevr.hu/thevrapps/HappyHour/ajax.hhvideos.php")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .loadPage(let targetPage):
            let parameters = ["srcTag": "", "page": "\(targetPage)"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
            
        case .searchEpisodes(let searchType, let query, let targetPage):
            var parameters = ["page": "\(targetPage)", "srcTag": ""]
            
            switch searchType {
            case .byPart:
                parameters["part"] = query
            case .byDate:
                parameters["date"] = query
            case .byText:
                parameters["srcTag"] = query
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
