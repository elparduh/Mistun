import Foundation

protocol CatsDependencyAssembler {
  func resolve(catsUIProtocol: CatsUIProtocol) -> CatsPresenterProtocol
  func resolve() -> CatsUseCaseProviderProtocol
  func resolve() -> CatsRepositoryProtocol
  func resolve() -> CatsDataSourceRemoteProtocol
  func resolve() -> APIClientProtocol
}

extension CatsDependencyAssembler {

  func resolve(catsUIProtocol: CatsUIProtocol) -> CatsPresenterProtocol {
    CatsPresenter(catsUseCaseProviderProtocol: resolve(), catsUIProtocol: catsUIProtocol)
  }

  func resolve() -> CatsUseCaseProviderProtocol {
    CatsUseCaseProvider(catsRepositoryProtocol: resolve())
  }

  func resolve() -> CatsRepositoryProtocol {
    CatsRepository(catsDataSourceRemoteProtocol: resolve())
  }

  func resolve() -> CatsDataSourceRemoteProtocol {
    CatsDataSourceRemote(apiClient: resolve())
  }

  func resolve() -> APIClientProtocol {
    APIClient()
  }
}

struct CatsAssemblerInjector : CatsDependencyAssembler { }
