//
//  OpenDocRouter.swift
//  SB-MDEditor
//
//  Created by Антон Заричный on 29.04.2023.
//

import UIKit

protocol IOpenDocRouter: MainRouting {}

final class OpenDocRouter: IOpenDocRouter {
	weak var view: IRootViewController?
}
