import Foundation

protocol CatsDataSourceRemoteProtocol {
  var apiClient: APIClientProtocol { get }
  func getCats() async throws -> [Cat]
}

struct CatsDataSourceRemote: CatsDataSourceRemoteProtocol {

  var apiClient: APIClientProtocol

  init(apiClient: APIClientProtocol) {
    self.apiClient = apiClient
  }

  func getCats() async throws -> [Cat] {
    try await apiClient.request(endpoint: MistunEndPoint.get10CatImages, type: [CatDTO].self).asToDomain()
  }
}
