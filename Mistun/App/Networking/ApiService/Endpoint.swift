import Foundation

enum HTTPMethodType: String {
  case get     = "GET"
  case post    = "POST"
}

protocol Endpoint {
  var path: String { get }
  var method: HTTPMethodType { get }
  var queryParametersEncodable: Encodable? { get }
  var queryParameters: [String: String] { get }
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
    var urlQueryItems = [URLQueryItem]()
    components.scheme = scheme
    components.host = host
    components.path = basePath + path
    let queryParameters = try queryParametersEncodable?.toDictionary() ?? queryParameters
    queryParameters.forEach {
        urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
    }
    components.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
    guard let url = components.url else {
      preconditionFailure("Invalid URL components: \(components)")
    }
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
