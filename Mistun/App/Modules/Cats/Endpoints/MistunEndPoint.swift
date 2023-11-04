import Foundation

enum MistunEndPoint {
  case get10CatImages
}

extension MistunEndPoint: Endpoint {

  var path: String { "/search" }
  var method: HTTPMethodType { .get }
  var queryItems: [URLQueryItem] {
    [URLQueryItem(name: "limit", value: "10")]
  }
}
