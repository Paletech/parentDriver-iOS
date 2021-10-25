//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `ic_eye_off`.
    static let ic_eye_off = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_eye_off")
    /// Image `ic_eye_on`.
    static let ic_eye_on = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_eye_on")
    /// Image `ic_logo`.
    static let ic_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_logo")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_eye_off", bundle: ..., traitCollection: ...)`
    static func ic_eye_off(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_eye_off, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_eye_on", bundle: ..., traitCollection: ...)`
    static func ic_eye_on(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_eye_on, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_logo", bundle: ..., traitCollection: ...)`
    static func ic_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_logo, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// en translation: Bus inspection
      ///
      /// Locales: en
      static let title_bus_inspection = Rswift.StringResource(key: "title_bus_inspection", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Change bus
      ///
      /// Locales: en
      static let title_change_bus = Rswift.StringResource(key: "title_change_bus", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Dashboard
      ///
      /// Locales: en
      static let title_dashboard = Rswift.StringResource(key: "title_dashboard", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Double-check your email
      ///
      /// Locales: en
      static let error_email = Rswift.StringResource(key: "error_email", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Driver Id
      ///
      /// Locales: en
      static let placeholder_driver_id = Rswift.StringResource(key: "placeholder_driver_id", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Logout
      ///
      /// Locales: en
      static let title_logout = Rswift.StringResource(key: "title_logout", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Monitor boarding
      ///
      /// Locales: en
      static let title_monitor_boarding = Rswift.StringResource(key: "title_monitor_boarding", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: No items were found for this query
      ///
      /// Locales: en
      static let error_empty_search = Rswift.StringResource(key: "error_empty_search", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Password
      ///
      /// Locales: en
      static let placeholder_password = Rswift.StringResource(key: "placeholder_password", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Ridership changes
      ///
      /// Locales: en
      static let title_ridersheep_changes = Rswift.StringResource(key: "title_ridersheep_changes", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: School Id
      ///
      /// Locales: en
      static let placeholder_school_id = Rswift.StringResource(key: "placeholder_school_id", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Search bus
      ///
      /// Locales: en
      static let placeholder_search_bus = Rswift.StringResource(key: "placeholder_search_bus", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Select bus
      ///
      /// Locales: en
      static let title_select_bus = Rswift.StringResource(key: "title_select_bus", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Sign In
      ///
      /// Locales: en
      static let button_sign_in = Rswift.StringResource(key: "button_sign_in", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Sign in
      ///
      /// Locales: en
      static let title_sign_in = Rswift.StringResource(key: "title_sign_in", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Sign up
      ///
      /// Locales: en
      static let button_sign_up = Rswift.StringResource(key: "button_sign_up", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Something went wrong. Please, try again.
      ///
      /// Locales: en
      static let error_general = Rswift.StringResource(key: "error_general", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: This field can't be empty
      ///
      /// Locales: en
      static let error_empty_field = Rswift.StringResource(key: "error_empty_field", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)

      /// en translation: Bus inspection
      ///
      /// Locales: en
      static func title_bus_inspection(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_bus_inspection", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_bus_inspection"
        }

        return NSLocalizedString("title_bus_inspection", bundle: bundle, comment: "")
      }

      /// en translation: Change bus
      ///
      /// Locales: en
      static func title_change_bus(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_change_bus", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_change_bus"
        }

        return NSLocalizedString("title_change_bus", bundle: bundle, comment: "")
      }

      /// en translation: Dashboard
      ///
      /// Locales: en
      static func title_dashboard(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_dashboard", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_dashboard"
        }

        return NSLocalizedString("title_dashboard", bundle: bundle, comment: "")
      }

      /// en translation: Double-check your email
      ///
      /// Locales: en
      static func error_email(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error_email", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "error_email"
        }

        return NSLocalizedString("error_email", bundle: bundle, comment: "")
      }

      /// en translation: Driver Id
      ///
      /// Locales: en
      static func placeholder_driver_id(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("placeholder_driver_id", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "placeholder_driver_id"
        }

        return NSLocalizedString("placeholder_driver_id", bundle: bundle, comment: "")
      }

      /// en translation: Logout
      ///
      /// Locales: en
      static func title_logout(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_logout", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_logout"
        }

        return NSLocalizedString("title_logout", bundle: bundle, comment: "")
      }

      /// en translation: Monitor boarding
      ///
      /// Locales: en
      static func title_monitor_boarding(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_monitor_boarding", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_monitor_boarding"
        }

        return NSLocalizedString("title_monitor_boarding", bundle: bundle, comment: "")
      }

      /// en translation: No items were found for this query
      ///
      /// Locales: en
      static func error_empty_search(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error_empty_search", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "error_empty_search"
        }

        return NSLocalizedString("error_empty_search", bundle: bundle, comment: "")
      }

      /// en translation: Password
      ///
      /// Locales: en
      static func placeholder_password(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("placeholder_password", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "placeholder_password"
        }

        return NSLocalizedString("placeholder_password", bundle: bundle, comment: "")
      }

      /// en translation: Ridership changes
      ///
      /// Locales: en
      static func title_ridersheep_changes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_ridersheep_changes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_ridersheep_changes"
        }

        return NSLocalizedString("title_ridersheep_changes", bundle: bundle, comment: "")
      }

      /// en translation: School Id
      ///
      /// Locales: en
      static func placeholder_school_id(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("placeholder_school_id", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "placeholder_school_id"
        }

        return NSLocalizedString("placeholder_school_id", bundle: bundle, comment: "")
      }

      /// en translation: Search bus
      ///
      /// Locales: en
      static func placeholder_search_bus(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("placeholder_search_bus", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "placeholder_search_bus"
        }

        return NSLocalizedString("placeholder_search_bus", bundle: bundle, comment: "")
      }

      /// en translation: Select bus
      ///
      /// Locales: en
      static func title_select_bus(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_select_bus", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_select_bus"
        }

        return NSLocalizedString("title_select_bus", bundle: bundle, comment: "")
      }

      /// en translation: Sign In
      ///
      /// Locales: en
      static func button_sign_in(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("button_sign_in", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "button_sign_in"
        }

        return NSLocalizedString("button_sign_in", bundle: bundle, comment: "")
      }

      /// en translation: Sign in
      ///
      /// Locales: en
      static func title_sign_in(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title_sign_in", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title_sign_in"
        }

        return NSLocalizedString("title_sign_in", bundle: bundle, comment: "")
      }

      /// en translation: Sign up
      ///
      /// Locales: en
      static func button_sign_up(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("button_sign_up", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "button_sign_up"
        }

        return NSLocalizedString("button_sign_up", bundle: bundle, comment: "")
      }

      /// en translation: Something went wrong. Please, try again.
      ///
      /// Locales: en
      static func error_general(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error_general", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "error_general"
        }

        return NSLocalizedString("error_general", bundle: bundle, comment: "")
      }

      /// en translation: This field can't be empty
      ///
      /// Locales: en
      static func error_empty_field(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error_empty_field", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "error_empty_field"
        }

        return NSLocalizedString("error_empty_field", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "ic_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
