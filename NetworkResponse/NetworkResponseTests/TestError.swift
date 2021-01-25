import Foundation

struct TestError: LocalizedError {
    let message: String

    var errorDescription: String? { message }
}
