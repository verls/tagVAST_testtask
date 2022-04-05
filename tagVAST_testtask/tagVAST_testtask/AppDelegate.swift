//
//  AppDelegate.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var services: Services!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initServices()
        
        return true
    }

    
    func initServices() {
        services = Services()
        services.append(ConfigService.self,implementation: ConfigImpl(services: services))
        services.append(DownloaderService.self, implementation: DownloaderImpl(services: services))
        services.append(ProviderService.self, implementation: PixabayProvider(services: services))
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

