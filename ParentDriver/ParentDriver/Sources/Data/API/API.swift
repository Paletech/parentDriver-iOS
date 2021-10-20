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
            default: return ""
            }
        }
    }

    struct Auth {
        private static let root = "/auth"
    }

    struct Device {
        private static let root = "/device"
        static let gcm = root + "/gcm/"
    }
}
