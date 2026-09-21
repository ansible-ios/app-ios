import Foundation
import UIKit
import OverlayStatusController
import IosappPresentationData
import Display

public func OverlayStatusController(theme: PresentationTheme, type: OverlayStatusControllerType) -> ViewController {
    return OverlayStatusController(style: theme.actionSheet.backgroundType == .light ? .light : .dark, type: type)
}
