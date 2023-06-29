import Foundation

func solution(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
    let todayComponents: [Int] = today.components(separatedBy: ".")
        .compactMap { Int($0) }
    let termComponents: [[String]] = terms.map { $0.components(separatedBy: " ") }
    let privacyComponents: [[String]] = privacies.map { $0.components(separatedBy: " ") }
    
    let termDic: [String: String] = .init(
        uniqueKeysWithValues: termComponents.map { ($0[0], $0[1]) }
    )
    let privacyArray: [(String, [String])] = privacyComponents.map {
        return ($0[1], $0[0].components(separatedBy: "."))
    }
    
    return privacyArray.enumerated().map { (index, value) in
        guard let termInt = Int(termDic[value.0] ?? "") else { return nil }
        
        let privacyValue: [String] = value.1
        
        var year: Int = (Int(privacyValue[0]) ?? 0)
        var month: Int = (Int(privacyValue[1]) ?? 0) + termInt
        let day: Int = (Int(privacyValue[2]) ?? 0)

        if month > 12 {
            year += (month % 12 != 0) ? (month / 12) : ((month / 12) - 1)
            month = (month % 12 != 0) ? (month % 12) : 12
        }
        
        guard year == todayComponents[0] else {
            return (year < todayComponents[0]) ? (index + 1) : nil
        }
        
        guard month == todayComponents[1] else {
            return (month < todayComponents[1]) ? (index + 1) : nil
        }
        
        guard day == todayComponents[2] else {
            return (day < todayComponents[2]) ? (index + 1) : nil
        }
        
        return (index + 1)
    }
    .compactMap { $0 }
}

print(solution("2022.05.19", ["A 6", "B 12", "C 3"], ["2021.05.02 A", "2021.07.01 B", "2022.02.19 C", "2022.02.20 C"]))
