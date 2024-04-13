import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let defaults = UserDefaults.standard
        let defaultValue = ["headline_title": "Sample Text that will change"]
        defaults.register(defaults: defaultValue)
        
        GeneratedPluginRegistrant.register(with: self)
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(5 * 60)) // Update every 5 minutes
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    override func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Update shared UserDefaults here
        let userDefaults = UserDefaults(suiteName: "group.widgetget")
        let title = userDefaults?.string(forKey: "headline_title") ??  "Sample Text that will change"
        // Call the completion handler when done
        completionHandler(.newData)
    }
    
}
