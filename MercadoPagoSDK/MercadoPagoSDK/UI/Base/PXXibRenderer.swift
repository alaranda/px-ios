import Foundation

class PXXibRenderer: UIView, PXXibComponentizable {
    func loadXib(rendererComponentizableClass: PXXibComponentizable) {
        let bundle = ResourceManager.shared.getBundle()
        bundle.loadNibNamed(rendererComponentizableClass.xibName(), owner: rendererComponentizableClass, options: nil)
        if let classView = rendererComponentizableClass as? UIView {
            let contentView = rendererComponentizableClass.containerView()
            classView.addSubview(contentView)
            contentView.frame = classView.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }

    func xibName() -> String {
        fatalError("\(#function) must be overridden")
    }

    func containerView() -> UIView {
        fatalError("\(#function) must be overridden")
    }

    func renderXib() -> UIView {
        fatalError("\(#function) must be overridden")
    }
}
