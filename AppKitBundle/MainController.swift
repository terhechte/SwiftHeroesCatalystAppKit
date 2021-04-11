import AppKit

@objc(SHMainController)
public final class MainController: NSObject {
    
    private weak var window: NSWindow?
    
    @objc public func setupWindow(_ window: NSWindow) {
        self.window = window
    }
    
    @objc public func numberOfScreens() -> NSNumber {
        NSNumber(value: NSScreen.screens.count)
    }
}
