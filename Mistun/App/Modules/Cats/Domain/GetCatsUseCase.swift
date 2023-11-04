import Foundation

protocol CatsUseCaseProtocol {
  var catsRepositoryProtocol: CatsRepositoryProtocol { get }
  func execute() async -> Result<[Cat], Error>
}

struct GetCatsUseCase: CatsUseCaseProtocol {

  var catsRepositoryProtocol: CatsRepositoryProtocol

  init(catsRepositoryProtocol: CatsRepositoryProtocol) {
    self.catsRepositoryProtocol = catsRepositoryProtocol
  }

  func execute() async -> Result<[Cat], Error> {
    do {
      let repositoryResult = try await catsRepositoryProtocol.getCats()
        return .success(repositoryResult)
    } catch {
        return .failure(error)
    }
  }
}
