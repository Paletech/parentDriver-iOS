import Foundation

extension Date {

    func isSameDate(_ comparisonDate: Date?) -> Bool {
        guard let comparisonDate = comparisonDate else { return false }
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedSame
    }

    func isBeforeDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedAscending
    }

    func isAfterDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedDescending
    }

    func toGlobalTime() -> Date {
        let timeInterval = TimeInterval(TimeZone.current.secondsFromGMT())
        return Date(timeInterval: -timeInterval, since: self)
    }

    func toLocalTime() -> Date {
        let seconds = TimeInterval(TimeZone.current.secondsFromGMT())
        return Date(timeInterval: seconds, since: self)
    }

}
