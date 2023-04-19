#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIView {
	struct Preview: UIViewRepresentable {
		let view: UIView

		func makeUIView(context: Context) -> UIView {
			view
		}

		func updateUIView(_ uiView: UIView, context: Context) {
			view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
			view.setContentHuggingPriority(.defaultHigh, for: .vertical)
		}
	}

	func preview() -> some View {
		Preview(view: self).previewLayout(.sizeThatFits)
	}
}
#endif
