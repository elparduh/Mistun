import Foundation

protocol CatsUseCaseProviderProtocol {
  var catsRepositoryProtocol: CatsRepositoryProtocol { get }
  func getCatsUseCaseProvider() -> GetCatsUseCase
}

struct CatsUseCaseProvider: CatsUseCaseProviderProtocol {

  var catsRepositoryProtocol: CatsRepositoryProtocol

  init(catsRepositoryProtocol: CatsRepositoryProtocol) {
    self.catsRepositoryProtocol = catsRepositoryProtocol
  }

  func getCatsUseCaseProvider() -> GetCatsUseCase {
    GetCatsUseCase(catsRepositoryProtocol: catsRepositoryProtocol)
  }
}
