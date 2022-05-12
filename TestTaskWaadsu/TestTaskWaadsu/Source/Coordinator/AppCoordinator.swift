//
//  AppCoordinator.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation
import UIKit

///Создаю класс AppCoordinator который будет стартовать модуль.
///Класс содержит в себе window, navigationControllers, AppDependency - зависимость контейнер с сервисами, для передачи в модули VIP
final class AppCoordinator {
    
    private let window: UIWindow
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private let appDependency: AppDependency
    
    init(
        window: UIWindow,
        appDependency: AppDependency
    ) {
        self.window = window
        self.appDependency = appDependency
        self.navigationControllers = AppCoordinator.makeNavigationControllers()
    }
    
    func start() {
        //режим интерфейса всегда белый
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        setupMap()
        
        let navigationController = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        
        window.rootViewController = navigationController[0]
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    
    ///Функция возвращает дикшинари, где ключ это enum, а значение UINavigationController
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        NavigationControllersType.allCases.forEach { key in
            let navigationController = UINavigationController()
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.sizeToFit()
            result[key] = navigationController
        }
        return result
    }
    
    ///Функция получает из дикшинари navigationController по ключу кейса map, собирает модуль VIP, добавляя context в котором наш контейнер с сервисами, устанавливает navigationItem тайтл для VC и устанавливаем VC в NC
    func setupMap() {
        guard let navController = self.navigationControllers[.map] else {
            fatalError("something wrong with appCoordinator")
        }
        let contex = ModuleContext(moduleDependencies: appDependency)
        let container = MapAssembly()
        let mapVC = container.makeModule(with: contex)
        mapVC.title = Localize.map
        navController.setViewControllers([mapVC], animated: true)
        setupAppearanceNavigationBar(with: navController)
    }
    
    ///Функция UINavigationBarAppearance устанавливает Appearance для NavigationBar
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                       .font : Font.sber(ofSize: Font.Size.twenty, weight: .bold)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font : Font.sber(ofSize: Font.Size.thirdyFour, weight: .bold),
                                                            .paragraphStyle: paragraphStyle,
                                                            .kern: 0.41]
        UINavigationBar.appearance().tintColor = .blue
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        controller.navigationBar.isTranslucent = false
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
    }
}

///Enum NavigationControllersType содержит в себе cases типа Int и переменyую title для настройки функции makeNavigationControllers
fileprivate enum NavigationControllersType: Int, CaseIterable {
    case map
    var title: String {
        switch self {
        case .map:
            return Localize.map
        }
    }
}
