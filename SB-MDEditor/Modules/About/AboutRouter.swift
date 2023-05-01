//
//  AboutRouter.swift
//  SB-MDEditor
//
//  Created by SERGEY SHLYAKHIN on 02.05.2023.
//

import UIKit

protocol IAboutRouter: MainRouting {}

final class AboutRouter: IAboutRouter {
	weak var view: IRootViewController?
}
