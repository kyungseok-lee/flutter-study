import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

     GMSServices.provideAPIKey("AIzaSyAIWT4T8PTT1Gl6NpMv5AuNmV0wf664Hvc")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
