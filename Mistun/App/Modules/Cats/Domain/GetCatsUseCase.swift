import Foundation
import RxSwift

protocol CatsUseCaseProtocol {
  var catsRepositoryProtocol: CatsRepositoryProtocol { get }
  func getCats() -> Observable<[Cat]>
}

struct GetCatsUseCase: CatsUseCaseProtocol {

  var catsRepositoryProtocol: CatsRepositoryProtocol

  init(catsRepositoryProtocol: CatsRepositoryProtocol) {
    self.catsRepositoryProtocol = catsRepositoryProtocol
  }

  func getCats() -> Observable<[Cat]> {
    catsRepositoryProtocol.getCats()
  }
}
