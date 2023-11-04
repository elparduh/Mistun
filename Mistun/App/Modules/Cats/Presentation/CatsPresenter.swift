import Foundation

protocol CatsUIProtocol {
    func showError(_ error: String)
    func showLoader()
    func hideLoader()
    func showCats(_ cats: [Cat])
}

protocol DogsPresenterProtocol {
  var catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol { get }
  var catsUIProtocol: CatsUIProtocol { get }
  func fechtCats()
}

struct CatsPresenter: DogsPresenterProtocol {

  var catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol
  var catsUIProtocol: CatsUIProtocol

  init(catsUseCaseProviderProtocol: CatsUseCaseProviderProtocol, catsUIProtocol: CatsUIProtocol) {
    self.catsUseCaseProviderProtocol = catsUseCaseProviderProtocol
    self.catsUIProtocol = catsUIProtocol
  }

  func fechtCats() {
    Task {
      catsUIProtocol.showLoader()
      let result = await catsUseCaseProviderProtocol.getCatsUseCaseProvider().execute()
      switch result {
      case .success(let cats):
        catsUIProtocol.hideLoader()
        catsUIProtocol.showCats(cats)
      case .failure(let error):
        catsUIProtocol.hideLoader()
        catsUIProtocol.showError(error.localizedDescription)
      }
    }
  }
}
