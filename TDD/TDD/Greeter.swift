struct Greeter {
    #if false
    private let greetingTimes: [(from: Int, greeting: String)] = [
        (0, "Good evening."),
        (5, "Good morning."),
        (12, "Good afternoon."),
        (17, "Good evening."),
        (24, "SENTINEL"),
    ]
    #endif

    private let greetingTimes: [(from: Int, greeting: String)] = [
        (0, "Good evening"),
        (5, "Good morning"),
        (12, "Good afternoon"),
        (17, "Good evening"),
        (24, "SENTINEL"),
    ]

    #if false
    init(name: String) {
    }
    #endif

    private let name: String

    init(name: String) {
        self.name = name
    }

    #if false
    func greet(time: Date) -> String {
        return "BOGUS"
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let components = Calendar.current.dateComponents([.hour], from: time)
        if components.hour! == 12 {
            return "Good afternoon."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let components = Calendar.current.dateComponents([.hour], from: time)
        if components.hour ?? 0 == 12 {
            return "Good afternoon."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        if hour(for: time) == 12 {
            return "Good afternoon."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        /*
        if hour(for: time) == 12 || hour(for: time) == 16 {
        */
        /*
        let theHour = hour(for: time)
        if theHour == 12 || theHour == 16 {
        */
        let theHour = hour(for: time)
        /*
        if theHour == 12 || theHour == 14 || theHour == 16 {
        */
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        if 0 <= theHour && theHour <= 4 ||
                   17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        if 0 <= theHour && theHour <= 4 ||
                   17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        if 0 <= theHour && theHour <= 4 ||
                   17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        if 0 <= theHour && theHour <= 4 {
            return "Good evening."
        }
        if 17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        return "Good morning."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 0 <= theHour && theHour <= 4 {
            return "Good evening."
        }
        if 5 <= theHour && theHour <= 11 {
            return "Good morning."
        }
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        if 17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 0 <= theHour && theHour < 5 {
            return "Good evening."
        }
        if 5 <= theHour && theHour < 12 {
            return "Good morning."
        }
        if 12 <= theHour && theHour < 17 {
            return "Good afternoon."
        }
        if 17 <= theHour && theHour < 24 {
            return "Good evening."
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if 0 <= theHour && theHour < 5 {
            return greetingTimes[0].greeting
        }
        if 5 <= theHour && theHour < 12 {
            return greetingTimes[1].greeting
        }
        if 12 <= theHour && theHour < 17 {
            return greetingTimes[2].greeting
        }
        if 17 <= theHour && theHour < 24 {
            return greetingTimes[3].greeting
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        if greetingTimes[0].from <= theHour && theHour < greetingTimes[1].from {
            return greetingTimes[0].greeting
        }
        if greetingTimes[1].from <= theHour && theHour < greetingTimes[2].from {
            return greetingTimes[1].greeting
        }
        if greetingTimes[2].from <= theHour && theHour < greetingTimes[3].from {
            return greetingTimes[2].greeting
        }
        if greetingTimes[3].from <= theHour && theHour < greetingTimes[4].from {
            return greetingTimes[3].greeting
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour &&
                       theHour < greetingTimes[index + 1].from {
                return greetingTime.greeting
            }
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        if !name.isEmpty {
            return "Good morning, Alberto."
        }
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour &&
                       theHour < greetingTimes[index + 1].from {
                return greetingTime.greeting + "."
            }
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour &&
                       theHour < greetingTimes[index + 1].from {
                #if false
                if !name.isEmpty {
                    return "\(greetingTime.greeting), Alberto."
                }
                #endif
                if !name.isEmpty {
                    return "\(greetingTime.greeting), \(name)."
                }
                return greetingTime.greeting + "."
            }
        }
        return ""
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let hello = greeting(for: time)
        if !name.isEmpty {
            return "\(hello), \(name)."
        }
        return hello + "."
    }
    #endif

    #if false
    func greet(time: Date) -> String {
        let hello = greeting(for: time)
        if name.isEmpty {
            return hello + "."
        } else {
            return "\(hello), \(name)."
        }
    }
    #endif

    func greet(time: Date) -> String {
        let hello = greeting(for: time)
        if name.isEmpty {
            return "\(hello)."
        } else {
            return "\(hello), \(name)."
        }
    }

    private func greeting(for time: Date) -> String {
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour &&
                       theHour < greetingTimes[index + 1].from {
                return greetingTime.greeting
            }
        }
        return ""
    }

    private func hour(for time: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: time)
        return components.hour ?? 0
    }
}
