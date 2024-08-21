//
//  UIApplicationExtension.swift
//  MediaList
//
//  Created by KaiD on 08/02/2023.
//

import Foundation
import UIKit

extension UIApplication {
    func findTopController(_ controller: UIViewController? = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController) -> UIViewController? {
        if let controller = controller as? UINavigationController {
            return findTopController(controller.topViewController)
        }
        if let controller = controller as? UITabBarController {
            return findTopController(controller.selectedViewController)
        }
        if let controller = controller?.presentedViewController {
            return findTopController(controller)
        }
        return controller
    }
}
