import UIKit

final class Di {
	weak var rootVC: IRootViewController?
	// MARK: - глобальные сервисы-зависимости

	// MARK: - инициализация глобальных сервисов
	init(rootVC: IRootViewController) {
		self.rootVC = rootVC
	}
}
