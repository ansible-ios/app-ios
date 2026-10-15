import Foundation
import libphonenumber
import AccountContext
import IosappCore

private let phoneNumberUtil = NBPhoneNumberUtil()

public func cleanPhoneNumber(_ text: String, removePlus: Bool = false) -> String {
    var result = ""
    for c in text {
        if c == "+" && !removePlus {
            if result.isEmpty {
                result += String(c)
            }
        } else if c >= "0" && c <= "9" {
            result += String(c)
        }
    }
    return result
}

// Анонимные номера (crystalpiece): префикс из appConfig fragment_prefixes плюс 1..8 цифр
// абонента, показ группами по 4 слева (+777 8, +777 1234 8, +777 8728 1723). Префиксы
// приходят с сервера; запасной — "777" (на холодном старте и до авторизации appConfig ещё нет).
private let fallbackAnonymousNumberPrefixes: [String] = ["777"]
private let maxAnonymousSubscriberLength = 8

public func anonymousNumberPrefixes(context: AccountContext) -> [String] {
    if let prefixes = context.currentAppConfiguration.with({ $0 }).data?["fragment_prefixes"] as? [String] {
        let clean = prefixes.filter { !$0.isEmpty }
        if !clean.isEmpty {
            return clean
        }
    }
    return fallbackAnonymousNumberPrefixes
}

private func matchedAnonymousNumberPrefix(_ digits: String, prefixes: [String]) -> String? {
    for prefix in prefixes {
        if !prefix.isEmpty && digits.hasPrefix(prefix) {
            let subscriberLength = digits.count - prefix.count
            if subscriberLength >= 1 && subscriberLength <= maxAnonymousSubscriberLength {
                return prefix
            }
        }
    }
    return nil
}

public func isAnonymousPhoneNumber(_ number: String, prefixes: [String]) -> Bool {
    return matchedAnonymousNumberPrefix(cleanPhoneNumber(number, removePlus: true), prefixes: prefixes) != nil
}

private func formatAnonymousPhoneNumber(_ number: String, prefixes: [String]) -> String {
    let digits = cleanPhoneNumber(number, removePlus: true)
    guard let prefix = matchedAnonymousNumberPrefix(digits, prefixes: prefixes) else {
        return "+" + digits
    }
    var result = "+" + prefix
    for (index, character) in digits.dropFirst(prefix.count).enumerated() {
        if index % 4 == 0 {
            result.append(" ")
        }
        result.append(character)
    }
    return result
}

public func formatPhoneNumber(_ string: String) -> String {
    if isAnonymousPhoneNumber(string, prefixes: fallbackAnonymousNumberPrefixes) {
        return formatAnonymousPhoneNumber(string, prefixes: fallbackAnonymousNumberPrefixes)
    }
    do {
        let number = try phoneNumberUtil.parse("+" + string, defaultRegion: nil)
        return try phoneNumberUtil.format(number, numberFormat: .INTERNATIONAL)
    } catch _ {
        return string
    }
}

public func formatPhoneNumber(context: AccountContext, number: String) -> String {
    let prefixes = anonymousNumberPrefixes(context: context)
    if isAnonymousPhoneNumber(number, prefixes: prefixes) {
        return formatAnonymousPhoneNumber(number, prefixes: prefixes)
    }
    if let pattern = lookupPatternByNumber(number, configuration: context.currentCountriesConfiguration.with { $0 }) {
        return "+\(formatPhoneNumberToMask(number, mask: pattern))"
    } else {
        do {
            let number = try phoneNumberUtil.parse("+" + number, defaultRegion: nil)
            return try phoneNumberUtil.format(number, numberFormat: .INTERNATIONAL)
        } catch _ {
            return number
        }
    }
}

private func removePlus(_ text: String?) -> String {
    var result = ""
    if let text = text {
        for c in text {
            if c != "+" {
                result += String(c)
            }
        }
    }
    return result
}

public func lookupCountryIdByNumber(_ number: String, configuration: CountriesConfiguration) -> (Country, Country.CountryCode)? {
    let number = removePlus(number)
    var results: [(Country, Country.CountryCode)]? = nil
    for i in 0 ..< number.count {
        let prefix = String(number.prefix(number.count - i))
        if let country = configuration.countriesByPrefix[prefix] {
            if var currentResults = results {
                if let result = currentResults.first, result.1.code.count > country.1.code.count {
                    break
                } else {
                    currentResults.append(country)
                }
            } else {
                results = [country]
            }
        }
    }
    return results?.first
}

private func lookupPatternByNumber(_ number: String, configuration: CountriesConfiguration) -> String? {
    let number = removePlus(number)
    if let (_, code) = lookupCountryIdByNumber(number, configuration: configuration) {
        // Отфильтровать пустые шаблоны: у FT/анонимных сервер может прислать patterns=[] или [""].
        let patterns = code.patterns.filter { !$0.isEmpty }
        if patterns.isEmpty {
            return nil
        }
        var prefixes: [String: String] = [:]
        for pattern in patterns {
            let cleanPattern = pattern.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "X", with: "")
            let cleanPrefix = "\(code.code)\(cleanPattern)"
            prefixes[cleanPrefix] = pattern
        }
        for i in 0..<number.count {
            let prefix = String(number.prefix(number.count - i))
            if let pattern = prefixes[prefix] {
                return "\(String(repeating: "X", count: code.code.count)) \(pattern)"
            }
        }
        if let pattern = patterns.first {
            return "\(String(repeating: "X", count: code.code.count)) \(pattern)"
        } else {
            return nil
        }
    }
    return nil
}

public func formatPhoneNumberToMask(_ string: String, mask: String) -> String {
    let replacementCharacter: Character = "X"
    let pattern = mask.replacingOccurrences( of: "[0-9]", with: "X", options: .regularExpression)
    var pureNumber = string.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
    for index in 0 ..< pattern.count {
        guard index < pureNumber.count else { return pureNumber }
        let stringIndex = pattern.index(pattern.startIndex, offsetBy: index)
        let patternCharacter = pattern[stringIndex]
        guard patternCharacter != replacementCharacter else { continue }
        pureNumber.insert(patternCharacter, at: stringIndex)
    }
    return pureNumber
}

public func isViablePhoneNumber(_ string: String) -> Bool {
    return phoneNumberUtil.isViablePhoneNumber(string)
}
