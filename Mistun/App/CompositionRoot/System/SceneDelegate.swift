//
//  SceneDelegate.swift
//  Mistun
//
//  Created by Juan Ticante Vicente on 25/10/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let catsViewController = CatsViewController()
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = catsViewController
    window?.makeKeyAndVisible()
  }
}

