//
//  NetworkServices.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import Foundation

class NetworkService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        let params = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(params: params)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(with: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(keys.accessKey)"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var params = [String: String]()
        params["query"] = searchTerm
        params["count"] = String(30)
        return params
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    
}
