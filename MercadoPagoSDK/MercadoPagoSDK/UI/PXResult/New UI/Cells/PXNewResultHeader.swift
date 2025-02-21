import UIKit

struct PXNewResultHeaderData {
    let color: UIColor?
    let title: String
    let icon: UIImage?
    let iconURL: String?
    let badgeImage: UIImage?
    let closeAction: (() -> Void)?
}

class PXNewResultHeader: UIView {
    let data: PXNewResultHeaderData

    init(data: PXNewResultHeaderData) {
        self.data = data
        super.init(frame: .zero)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Image
    let IMAGE_WIDTH: CGFloat = 48.0
    let IMAGE_HEIGHT: CGFloat = 48.0

    // Badge Image
    let BADGE_IMAGE_SIZE: CGFloat = 16
    let BADGE_HORIZONTAL_OFFSET: CGFloat = -2.0
    let BADGE_VERTICAL_OFFSET: CGFloat = 0.0

    // Close Button
    let CLOSE_BUTTON_SIZE: CGFloat = 44

    // Text
    static let TITLE_FONT_SIZE: CGFloat = PXLayout.L_FONT

    var iconImageView: PXUIImageView?
    var badgeImageView: UIImageView?
    var closeButton: UIButton?
    var titleLabel: UILabel?

    func render() {
        removeAllSubviews()
        backgroundColor = data.color

        // Close button
        if let closeAction = data.closeAction {
            let closeButton = buildCloseButton(touchUpInsideClosure: closeAction)
            self.closeButton = closeButton
            addSubview(closeButton)
            PXLayout.pinTop(view: closeButton, withMargin: PXLayout.XXXS_MARGIN).isActive = true
            PXLayout.pinLeft(view: closeButton, withMargin: PXLayout.S_MARGIN).isActive = true
        }

        // Title Label
        let titleLabel = buildTitleLabel(with: data.title)
        self.titleLabel = titleLabel
        addSubview(titleLabel)

        if let closeButton = self.closeButton {
            PXLayout.put(view: titleLabel, onBottomOf: closeButton, withMargin: PXLayout.XXXS_MARGIN).isActive = true
        } else {
            PXLayout.pinTop(view: titleLabel, withMargin: PXLayout.SM_MARGIN).isActive = true
        }

        PXLayout.pinBottom(view: titleLabel, withMargin: PXLayout.SM_MARGIN).isActive = true
        PXLayout.pinLeft(view: titleLabel, withMargin: PXLayout.L_MARGIN).isActive = true

        // Icon ImageView
        if let imageURL = data.iconURL, imageURL.isNotEmpty {
            let pximage = PXUIImage(url: imageURL)
            iconImageView = buildCircleImage(with: pximage)
        } else {
            iconImageView = buildCircleImage(with: data.icon)
        }
        if let circleImage = iconImageView {
            addSubview(circleImage)
            PXLayout.centerVertically(view: circleImage, to: titleLabel).isActive = true
            PXLayout.pinRight(view: circleImage, withMargin: PXLayout.L_MARGIN).isActive = true

            // Title label layout
            PXLayout.put(view: titleLabel, leftOf: circleImage, withMargin: PXLayout.S_MARGIN).isActive = true

            // Badge Image
            let badgeImageView = UIImageView()
            self.badgeImageView = badgeImageView
            badgeImageView.image = data.badgeImage
            badgeImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(badgeImageView)
            PXLayout.setWidth(owner: badgeImageView, width: BADGE_IMAGE_SIZE).isActive = true
            PXLayout.setHeight(owner: badgeImageView, height: BADGE_IMAGE_SIZE).isActive = true
            PXLayout.pinRight(view: badgeImageView, to: circleImage, withMargin: BADGE_HORIZONTAL_OFFSET).isActive = true
            PXLayout.pinBottom(view: badgeImageView, to: circleImage, withMargin: BADGE_VERTICAL_OFFSET).isActive = true
        } else {
            // Title label layout
            PXLayout.pinRight(view: titleLabel, withMargin: PXLayout.L_MARGIN).isActive = true
        }

        if let button = closeButton {
            accessibilityElements = [titleLabel, button]
        }
        self.layoutIfNeeded()
    }

    private func buildCloseButton(touchUpInsideClosure: @escaping () -> Void) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = ResourceManager.shared.getImage("result-close-button")
        button.contentEdgeInsets = UIEdgeInsets.zero
        button.setImage(image, for: .normal)
        button.accessibilityIdentifier = "result_close_button"
        button.add(for: .touchUpInside, touchUpInsideClosure)
        button.accessibilityLabel = "cerrar".localized
        PXLayout.setHeight(owner: button, height: CLOSE_BUTTON_SIZE).isActive = true
        PXLayout.setWidth(owner: button, width: CLOSE_BUTTON_SIZE).isActive = true
        return button
    }

    private func buildCircleImage(with image: UIImage?) -> PXUIImageView {
        return PXUIImageView(image: image, size: IMAGE_WIDTH, contentMode: .scaleAspectFill)
    }

    private func buildTitleLabel(with text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: PXLayout.M_FONT)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.lineBreakMode = .byTruncatingTail
        PXLayout.setHeight(owner: titleLabel, height: IMAGE_HEIGHT, relation: .greaterThanOrEqual).isActive = true
        return titleLabel
    }
}
