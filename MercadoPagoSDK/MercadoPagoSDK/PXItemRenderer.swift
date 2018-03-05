//
//  PXItemRenderer.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 3/1/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import Foundation

struct PXItemRenderer {
    let CONTENT_WIDTH_PERCENT: CGFloat = 86.0

    // Font sizes
    static let DESCRIPTION_FONT_SIZE = PXLayout.M_FONT
    static let QUANTITY_FONT_SIZE = PXLayout.XS_FONT
    static let AMOUNT_FONT_SIZE = PXLayout.XS_FONT

    func render(_ itemComponent: PXItemComponent) -> UIView {
        let itemView = PXItemContainerView()
        itemView.backgroundColor = UIColor.px_grayBackgroundColor()
        itemView.translatesAutoresizingMaskIntoConstraints = false

        itemView.itemImage = buildItemImage(imageURL: itemComponent.props.imageURL)

        // Item icon
        if let itemImage = itemView.itemImage {
            itemView.addSubview(itemImage)
            PXLayout.centerHorizontally(view: itemImage).isActive = true
            PXLayout.pinTop(view: itemImage, withMargin: PXLayout.L_MARGIN).isActive = true
        }

        // Item description
        if itemComponent.shouldShowDescription() {
            itemView.itemDescription = buildDescription(with: itemComponent.getDescription())
        }
        if let itemDescription = itemView.itemDescription {
            itemView.addSubviewToButtom(itemDescription, withMargin: PXLayout.XS_MARGIN)
            PXLayout.centerHorizontally(view: itemDescription).isActive = true
            PXLayout.matchWidth(ofView: itemDescription, withPercentage: CONTENT_WIDTH_PERCENT).isActive = true
        }

        // Item quantity
        if itemComponent.shouldShowQuantity() {
            itemView.itemQuantity = buildQuantity(with: itemComponent.getQuantity())
        }
        if let itemQuantity = itemView.itemQuantity {
            itemView.addSubviewToButtom(itemQuantity, withMargin: PXLayout.XS_MARGIN)
            PXLayout.centerHorizontally(view: itemQuantity).isActive = true
            PXLayout.matchWidth(ofView: itemQuantity, withPercentage: CONTENT_WIDTH_PERCENT).isActive = true
        }

        // Item amount
        if itemComponent.shouldShowUnitAmount() {
            itemView.itemAmount = buildItemAmount(with: itemComponent.getUnitAmountPrice(), title: itemComponent.getUnitAmountTitle())
        }
        if let itemAmount = itemView.itemAmount {
            let margin = itemView.itemQuantity == nil ? PXLayout.XS_MARGIN : PXLayout.XXXS_MARGIN
            itemView.addSubviewToButtom(itemAmount, withMargin: margin)
            PXLayout.centerHorizontally(view: itemAmount).isActive = true
            PXLayout.matchWidth(ofView: itemAmount, withPercentage: CONTENT_WIDTH_PERCENT).isActive = true
        }

        itemView.pinLastSubviewToBottom(withMargin: PXLayout.L_MARGIN)?.isActive = true
        return itemView
    }

    fileprivate func buildItemImage(imageURL: String?, collectorImage: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView()

        if let image =  ViewUtils.loadImageFromUrl(imageURL) {
            imageView.image = image
        }
         else if let image =  collectorImage {
            imageView.image = image
        } else {
            imageView.image = MercadoPago.getImage("MPSDK_review_iconoCarrito")
        }
        return imageView
    }

    fileprivate func buildDescription(with text: String?) -> UILabel? {
        guard let text = text else {
            return nil
        }

        let font = Utils.getFont(size: PXItemRenderer.DESCRIPTION_FONT_SIZE)
        let color = UIColor.px_grayDark()
        return buildLabel(text: text, color: color, font: font)
    }

    func buildQuantity(with text: String?) -> UILabel? {
        guard let text = text else {
            return nil
        }

        let font = Utils.getFont(size: PXItemRenderer.QUANTITY_FONT_SIZE)
        let color = UIColor.px_grayDark()
        return buildLabel(text: text, color: color, font: font)
    }

    fileprivate func buildItemAmount(with amount: Double?, title: String?) -> UILabel? {
        guard let title = title, let amount = amount else {
            return nil
        }

        let font = Utils.getFont(size: PXItemRenderer.AMOUNT_FONT_SIZE)
        let color = UIColor.px_grayDark()

        let unitPrice = buildAttributedUnitAmount(amount: amount, color: color, fontSize: font.pointSize)
        let unitPriceTitle = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: font])
        unitPriceTitle.append(unitPrice)

        return buildLabel(attributedText: unitPriceTitle, color: color, font: font)
    }

    fileprivate func buildAttributedUnitAmount(amount: Double, color: UIColor, fontSize: CGFloat) -> NSAttributedString {
        let currency = MercadoPagoContext.getCurrency()
        return Utils.getAmountFormatted(amount: amount, thousandSeparator: currency.thousandsSeparator, decimalSeparator: currency.decimalSeparator, addingCurrencySymbol: currency.symbol).toAttributedString()
    }

    fileprivate func buildLabel(text: String, color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = text
        label.textColor = color
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = font
        let screenWidth = PXLayout.getScreenWidth(applyingMarginFactor: CONTENT_WIDTH_PERCENT)
        let height = UILabel.requiredHeight(forText: text, withFont: font, inWidth: screenWidth)
        PXLayout.setHeight(owner: label, height: height).isActive = true
        return label
    }

    fileprivate func buildLabel(attributedText: NSAttributedString, color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = color
        label.attributedText = attributedText
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = font
        let screenWidth = PXLayout.getScreenWidth(applyingMarginFactor: CONTENT_WIDTH_PERCENT)
        let height = UILabel.requiredHeight(forAttributedText: attributedText, withFont: font, inWidth: screenWidth)
        PXLayout.setHeight(owner: label, height: height).isActive = true
        return label
    }
}

class PXItemContainerView: PXComponentView {
    var itemImage: UIImageView?
    var itemDescription: UILabel?
    var itemQuantity: UILabel?
    var itemAmount: UILabel?
}
