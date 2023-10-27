import Foundation

enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethodType { get }
}

extension Endpoint {
    var scheme: String {"https"}
    var host: String { "api.thecatapi.com" }
    var basePath: String { "/v1/images" }
}

extension Endpoint {

    func urlRequest() throws -> URLRequest {
        let url = try asUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }

    func asUrl() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + path
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
