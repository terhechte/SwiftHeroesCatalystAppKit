import AppKit

@objc(SHMainController)
public final class MainController: NSObject {
    
    private weak var window: NSWindow?
    
    private static let selectorForAction: Selector = NSSelectorFromString("actionForSelection:")
    private var actionClosure: ((String) -> Void)?
    
    @objc public func setupWindow(_ window: NSWindow) {
        self.window = window
    }
    
    @objc public func numberOfScreens() -> NSNumber {
        NSNumber(value: NSScreen.screens.count)
    }
    
    @objc(setDelegate:)
    func setDelegate(_ delegate: NSObject) {
        /// We can't check for protocol conformance as that differs between AppKit and UIKit.
        /// So what we do is manually make sure the conformance holds
        guard delegate.responds(to: Self.selectorForAction) else {
            fatalError("The delegate has to conform to \(Self.selectorForAction)")
        }
        actionClosure = {
            delegate.perform(Self.selectorForAction, with: $0)
        }
    }
    
    @objc(showCustomWindow)
    func showCustomWindow() {
        let window = NSWindow()
        let label = NSTextField(labelWithString: "AppKit")
        let button = NSButton(title: "Close", target: self, action: #selector(self.didTapClose))
        let stackView = NSStackView(views: [
            label, button
        ])
        window.contentView?.addSubview(stackView)
        window.makeKeyAndOrderFront(nil)
        self.window = window
    }
    
    @objc func didTapClose() {
        window?.close()
        actionClosure?("Hello from AppKit")
    }
}
