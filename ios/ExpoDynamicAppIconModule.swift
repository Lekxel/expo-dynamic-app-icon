import ExpoModulesCore

public class ExpoDynamicAppIconModule: Module {
  public func definition() -> ModuleDefinition {
    
    Name("ExpoDynamicAppIcon")

   Function("setAppIcon") { (name: String?) -> String in
   let iconName: String? = {
    guard let name = name, !name.isEmpty else {
      return nil   // ← THIS enables reset to default
    }
    return name
  }()
  
  self.setAppIconWithoutAlert(iconName)
  return iconName ?? "DEFAULT"
  
  }


    Function("getAppIcon") { () -> String in
      return UIApplication.shared.alternateIconName ?? "DEFAULT"
    }
  }

  private func setAppIconWithoutAlert(_ iconName: String?) {
    if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
      typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
      
      let selectorString = "_setAlternateIconName:completionHandler:"
      
      let selector = NSSelectorFromString(selectorString)
      let imp = UIApplication.shared.method(for: selector)
      let method = unsafeBitCast(imp, to: setAlternateIconName.self)
      method(UIApplication.shared, selector, iconName as NSString?, { _ in })
    }
  }

}
