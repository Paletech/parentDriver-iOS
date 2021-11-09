import CoreLocation

extension CLLocationCoordinate2D {
    
    func toCLLocation() -> CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var isValid: Bool {
        (latitude != 0.0) && (longitude != 0.0)
    }
}

extension CLLocation {
    
    var isValid: Bool {
        (coordinate.latitude != 0.0) && (coordinate.longitude != 0.0)
    }
}

extension CLLocationCoordinate2D {
    
    func contains(_ location: CLLocationCoordinate2D, with radius: Double) -> Bool {
        let region =  CLCircularRegion.init(center: self,
                                         radius: radius,
                                         identifier: "")
        
        return region.contains(location)
    }
    
    var toString: String { "\(latitude),\(longitude)" }
}

extension Array where Element == CLLocationCoordinate2D {
    
    func distance() -> Double {
        let output = stride(from: 0, to: self.count - 1, by: 1).map { (self[$0], self[$0 + 1]) }
        return output.compactMap { $0.0 + $0.1 }.reduce(0, +)
    }
}

infix operator +
extension CLLocationCoordinate2D {
    
    public static func + (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Double {
        let from = CLLocation(latitude: lhs.latitude, longitude: lhs.longitude)
        let to = CLLocation(latitude: rhs.latitude, longitude: rhs.longitude)
        return from.distance(from: to)
    }
}
