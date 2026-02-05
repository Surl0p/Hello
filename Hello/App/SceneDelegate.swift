//
//  SceneDelegate.swift
//  Hello
//
//  Created by Ivan Pavlov on 05.02.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // создание первого экрана приложения
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootVC = HelloViewController()
        let navVC = UINavigationController(rootViewController: rootVC)

        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }

    // работа с памяться при закрытии приложения
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    // действия при активации приложения
    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    // дейсвтия при подготовке к закрытию (например, пауза в игре)
    func sceneWillResignActive(_ scene: UIScene) {
    }

    // дейсвтия при возобновление активности после фонового режима
    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    // действия при уходе в фоновый режим
    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

