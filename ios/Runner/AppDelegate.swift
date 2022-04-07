import UIKit
import Firebase
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    

GMSServices.provideAPIKey("AIzaSyBJRCrRpTTvsRW1bDI2KsuY1PyLgW7N1YU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
