#if targetEnvironment(macCatalyst)
import Foundation

private let bundleName = "AppKitBundle.bundle"

class AppKitAdapter {
    
    private static var principalClass: NSObject.Type? = {
        let bundle = Bundle.main
        guard let url = bundle.builtInPlugInsURL?.appendingPathComponent(bundleName),
              let appKitBundle = Bundle(path: url.path),
              bundle.load(),
              let cls = appKitBundle.principalClass as? NSObject.Type
        else {
            return nil
        }
        return cls
    }()
    
    private var appKitController: NSObject?
    
    func loadBundle() {
        guard let cls = Self.principalClass else { return }
        self.appKitController = cls.init()
    }
    
    func numberOfScreens() {
        let selector = NSSelectorFromString("numberOfScreens")
        guard let screens = appKitController?
            .perform(selector)?
            .takeRetainedValue() as? NSNumber
        else { return }
        print("Number Of Screens", screens.intValue)
    }
}
#endif
