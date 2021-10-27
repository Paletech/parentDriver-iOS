import Repository

struct API {

    enum Configuration: String {

        static var current: Configuration {
            #if DEVELOPMENT
            return .development
            #elseif QA
            return .qa
            #elseif PRODUCTION
            return .production
            #else
            return .development
            #endif
        }

        case development
        case qa
        case production

        var loger: Log {
            switch self {
            default: return DEBUGLog()
            }
        }
        
        var baseURL: String {
            switch self {
            default: return "https://hos.nationalfleettracking.com/busView/API/driverViewLT"
            }
        }
    }

    struct Auth {
        static let login = "/login.php"
    }
    
    struct Bus {
        static let get = "/getBusList.php"
    }
    
    struct MonitorBoarding {
        static let get = "/boarding.php"
    }

    struct Device {
        private static let root = "/device"
        static let gcm = root + "/gcm/"
    }
}
