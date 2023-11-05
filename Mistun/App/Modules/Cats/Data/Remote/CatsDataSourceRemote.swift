import Foundation
import RxSwift

protocol CatsDataSourceRemoteProtocol {
  var apiClient: APIClientProtocol { get }
  func getCats() -> Observable<[Cat]>
}

struct CatsDataSourceRemote: CatsDataSourceRemoteProtocol {

  var apiClient: APIClientProtocol

  init(apiClient: APIClientProtocol) {
    self.apiClient = apiClient
  }

  func getCats() -> Observable<[Cat]> {
    Observable.create { observer in
      let task = Task {
        do {
          let cats = try await apiClient.request(endpoint: MistunEndPoint.get10CatImages,
                                                 type: [CatDTO].self)
          observer.onNext(cats.asToDomain())
          observer.onCompleted()
        } catch {
          observer.onError(error)
        }
      }
      return Disposables.create {
        task.cancel()
      }
    }
  }
}
