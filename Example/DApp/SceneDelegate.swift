import UIKit
import Auth
import WalletConnectRelay
import WalletConnectNetworking
import WalletConnectModal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let signCoordinator = SignCoordinator()
    private let authCoordinator = AuthCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Networking.configure(projectId: InputConfig.projectId, socketFactory: DefaultSocketFactory())
        Auth.configure(crypto: DefaultCryptoProvider())
        
        let metadata = AppMetadata(
            name: "BRX by Breathonics",
            description: "Enter story mode by connecting your wallet",
            url: "breathonics.com",
            icons: ["https://avatars.githubusercontent.com/u/37784886"]
        )
        
        WalletConnectModal.configure(projectId: InputConfig.projectId, metadata: metadata)

        setupWindow(scene: scene)
    }

    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let tabController = UITabBarController()
        tabController.viewControllers = [
            signCoordinator.navigationController,
            authCoordinator.navigationController
        ]

        signCoordinator.start()
        authCoordinator.start()

        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
    }
}
