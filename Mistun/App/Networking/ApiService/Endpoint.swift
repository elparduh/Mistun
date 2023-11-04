import Foundation

enum HTTPMethodType: String {
  case get     = "GET"
  case post    = "POST"
}

protocol Endpoint {
  var path: String { get }
  var method: HTTPMethodType { get }
  var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
  var scheme: String { Constants.schemeURL }
  var host: String { Constants.host }
  var basePath: String { Constants.basePath }
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
    var urlQueryItems = [URLQueryItem]()
    components.scheme = scheme
    components.host = host
    components.path = basePath + path
    components.queryItems = queryItems

    guard let url = components.url else { throw RequestGenerationError.components }
    return url
  }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
