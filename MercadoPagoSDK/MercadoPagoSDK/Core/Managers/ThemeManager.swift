import Foundation
import MLUI

class ThemeManager {
    static let shared = ThemeManager()

    fileprivate var currentTheme: PXTheme = PXDefaultTheme(withPrimaryColor: #colorLiteral(red: 0.2196078431, green: 0.5411764706, blue: 0.8156862745, alpha: 1)) {
        didSet {
            initialize()
        }
    }

    fileprivate var currentStylesheet = MLStyleSheetManager.styleSheet
    fileprivate var fontName: String = ".SFUIDisplay-Regular"
    fileprivate var fontLightName: String = ".SFUIDisplay-Light"
    fileprivate var fontSemiBoldName: String = ".SFUIDisplay-SemiBold"

    var navigationControllerMemento: NavigationControllerMemento?
}

// MARK: - Public methods
extension ThemeManager {
    func initialize() {
        currentStylesheet = MLStyleSheetManager.styleSheet
        customizeNavigationBar(theme: currentTheme)
        customizeToolBar()
    }

    func setDefaultColor(color: UIColor) {
        let customTheme = PXDefaultTheme(withPrimaryColor: color)
        let customStyleSheet = PXDefaultMLStyleSheet(withPrimaryColor: color)
        MLStyleSheetManager.styleSheet = customStyleSheet
        self.currentTheme = customTheme
    }

    func setTheme(theme: PXTheme) {
        self.currentTheme = theme
        if let externalFont = theme.fontName?() {
            fontName = externalFont
        }
        if let externalLightFont = theme.lightFontName?() {
            fontLightName = externalLightFont
        }
        if let externalSemiBoldFont = theme.semiBoldFontName?() {
            fontSemiBoldName = externalSemiBoldFont
        }
    }

    func getCurrentTheme() -> PXTheme {
        return currentTheme
    }

    func getFontName() -> String {
        return fontName
    }

    func getLightFontName() -> String {
        return fontLightName
    }

    func getSemiBoldFontName() -> String {
        return fontSemiBoldName
    }
}

extension ThemeManager {
    func boldLabelTintColor() -> UIColor {
        return currentStylesheet.blackColor
    }

    func labelTintColor() -> UIColor {
        return currentStylesheet.darkGreyColor
    }

    func midLabelTintColor() -> UIColor {
        return currentStylesheet.midGreyColor
    }

    func lightTintColor() -> UIColor {
        return currentStylesheet.lightGreyColor
    }

    func greyColor() -> UIColor {
        return currentStylesheet.greyColor
    }

    func whiteColor() -> UIColor {
        return currentStylesheet.whiteColor
    }

    func successColor() -> UIColor {
        return currentStylesheet.successColor
    }

    func remedyWarningColor() -> UIColor {
        return #colorLiteral(red: 1, green: 0.4663783312, blue: 0.2018467486, alpha: 1) // currentStylesheet.warningColor
    }

    func warningColor() -> UIColor {
        return currentStylesheet.warningColor
    }

    func rejectedColor() -> UIColor {
        return currentStylesheet.errorColor
    }

    func secondaryColor() -> UIColor {
        return currentStylesheet.secondaryColor
    }

    func placeHolderColor() -> UIColor {
        return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }

    func iconBackgroundColor() -> UIColor {
        return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }

    func noTaxAndDiscountLabelTintColor() -> UIColor {
        return #colorLiteral(red: 0, green: 0.6509803922, blue: 0.3137254902, alpha: 1)
    }

    func discountBriefColorML() -> UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.45)
    }

    func discountBriefColorMP() -> UIColor {
        return UIColor.white.withAlphaComponent(0.8)
    }

    func disabledCardGray() -> UIColor {
        return #colorLiteral(red: 0.2862745098, green: 0.2862745098, blue: 0.2862745098, alpha: 1)
    }
}

// MARK: - UI design exceptions
extension ThemeManager: PXTheme {
    func navigationBar() -> PXThemeProperty {
        return currentTheme.navigationBar()
    }

    func loadingComponent() -> PXThemeProperty {
        return currentTheme.loadingComponent()
    }

    func highlightBackgroundColor() -> UIColor {
        return currentTheme.highlightBackgroundColor()
    }

    func detailedBackgroundColor() -> UIColor {
        return currentTheme.detailedBackgroundColor()
    }

    func statusBarStyle() -> UIStatusBarStyle {
        return currentTheme.statusBarStyle()
    }

    func getMainColor() -> UIColor {
        if let theme = currentTheme as? PXDefaultTheme {
            return theme.primaryColor
        }
        return currentTheme.navigationBar().backgroundColor
    }

    func getAccentColor() -> UIColor {
        if let theme = currentTheme as? PXDefaultTheme {
            return theme.primaryColor
        }
        return currentStylesheet.secondaryColor
    }

    func getTintColorForIcons() -> UIColor? {
        if currentTheme is PXDefaultTheme {
            return getMainColor()
        }
        return nil
    }

    func getTitleColorForReviewConfirmNavigation() -> UIColor {
        if currentTheme is PXDefaultTheme {
            return getMainColor()
        }

        if let highlightNavigationTint = currentTheme.highlightNavigationTintColor?() {
            return highlightNavigationTint
        }

        return boldLabelTintColor()
    }

    func modalComponent() -> PXThemeProperty {
        return PXThemeProperty(backgroundColor: currentStylesheet.modalBackgroundColor, tintColor: currentStylesheet.modalTintColor)
    }
}

// MARK: - UI Theme customization
extension ThemeManager {
    fileprivate func customizeNavigationBar(theme: PXTheme) {
        UINavigationBar.appearance(whenContainedInInstancesOf: [MercadoPagoUIViewController.self]).tintColor = theme.navigationBar().tintColor
        UINavigationBar.appearance(whenContainedInInstancesOf: [MercadoPagoUIViewController.self]).backgroundColor = theme.navigationBar().backgroundColor
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [MercadoPagoUIViewController.self]).tintColor = theme.navigationBar().tintColor
        PXNavigationHeaderLabel.appearance().textColor = theme.navigationBar().tintColor
    }

    fileprivate func customizeToolBar() {
        PXToolbar.appearance().tintColor = getAccentColor()
        PXToolbar.appearance().backgroundColor = lightTintColor()
        PXToolbar.appearance().alpha = 1
    }
}
