import Foundation
import RxSwift

protocol CatsUIProtocol {
    func showError(_ error: String)
    func showLoader()
    func hideLoader()
    func showCats(_ cats: [Cat])
}

protocol CatsPresenterProtocol {
  var catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol { get }
  var catsUIProtocol: CatsUIProtocol { get }
  func fechtCats()
}

struct CatsPresenter: CatsPresenterProtocol {

  private let disposeBag = DisposeBag()
  var catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol
  var catsUIProtocol: CatsUIProtocol

  init(catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol, catsUIProtocol: CatsUIProtocol) {
    self.catsUseCaseProviderProtocol = catsUseCaseProviderProtocol
    self.catsUIProtocol = catsUIProtocol
  }

  func fechtCats() {
    catsUIProtocol.showLoader()
    catsUseCaseProviderProtocol.getCatsUseCaseProvider().getCats()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { cats in
        catsUIProtocol.showCats(cats)
      }, onError: { error in
        catsUIProtocol.showError(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
}
