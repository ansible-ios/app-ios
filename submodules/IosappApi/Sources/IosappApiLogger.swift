import Foundation

private var ansibleApiLogger: (String) -> Void = { _ in }

public func setIosappApiLogger(_ f: @escaping (String) -> Void) {
    ansibleApiLogger = f
}

func ansibleApiLog(_ what: @autoclosure () -> String) {
    ansibleApiLogger(what())
}
