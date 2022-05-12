//
//  Assembly.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import UIKit

struct ModuleContext {
    let moduleDependencies: ModuleDependencies
}

protocol Assembly {
    func makeModule(with context: ModuleContext?) -> UIViewController
}
