import Foundation
import RxSwift

protocol CatsRepositoryProtocol {
  var catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol { get }
  func getCats() -> Observable<[Cat]>
}

struct CatsRepository: CatsRepositoryProtocol {

  var catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol

  init(catsDataSourceRemoteProtocol: CatsDataSourceRemoteProtocol) {
    self.catsDataSourceRemoteProtocol = catsDataSourceRemoteProtocol
  }

  func getCats() -> Observable<[Cat]> {
    catsDataSourceRemoteProtocol.getCats()
  }
}
