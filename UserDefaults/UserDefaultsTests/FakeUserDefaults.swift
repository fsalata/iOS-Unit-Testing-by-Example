@testable import UserDefaults

class FakeUserDefaults: UserDefaultsProtocol {
    var integers: [String: Int] = [:]

    func set(_ value: Int, forKey defaultName: String) {
        integers[defaultName] = value
    }

    func integer(forKey defaultName: String) -> Int {
        integers[defaultName] ?? 0
    }
}
