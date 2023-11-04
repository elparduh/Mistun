import Foundation

protocol CatsRepositoryProtocol {
  var catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol { get }
  func getCats() async throws -> [Cat]
}

struct CatsRepository: CatsRepositoryProtocol {

  var catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol

  init(catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol) {
    self.catsDataSourceRemoteProtocol = catsDataSourceRemoteProtocol
  }

  func getCats() async throws -> [Cat] {
    try await catsDataSourceRemoteProtocol.getCats()
  }
}
