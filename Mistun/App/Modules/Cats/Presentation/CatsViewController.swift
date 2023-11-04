import UIKit

class CatsViewController: UIViewController {

  private let assemblerInjector = CatsAssemblerInjector()
  private var presenter: CatsPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    initializePresenter()
    presenter.fechtCats()
  }

  private func initializePresenter() {
    presenter = assemblerInjector.resolve(catsUIProtocol: self)
  }
}

extension CatsViewController: CatsUIProtocol {

  func showError(_ error: String) { }

  func showLoader() { }

  func hideLoader() { }

  func showCats(_ cats: [Cat]) {
    let cats = cats
    print(cats)
  }
}
