import Foundation

func reportSolution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    var result: [Int] = .init(repeating: 0, count: (id_list.count))
    var reportedDic: [String: Set<String>] = [:]
    var reporterDic: [String: Set<String>] = [:]
    
    let reported: [[String]] = report.map { $0.components(separatedBy: " ") }
    
    // 신고자-신고목록, 신고당한자-신고자 Dictionary 생성
    reported.forEach {
        if var reportedValue: Set<String> = reportedDic[$0[1]] {
            reportedValue.insert($0[0])
            reportedDic[$0[1]] = reportedValue
        } else {
            reportedDic[$0[1]] = [$0[0]]
        }
        
        if var reporterValue: Set<String> = reporterDic[$0[0]] {
            reporterValue.insert($0[1])
            reporterDic[$0[0]] = reporterValue
        } else {
            reporterDic[$0[0]] = [$0[1]]
        }
    }
    
    // k회 이상 신고 당한 유저
    let filtedReported: [String] = reportedDic.filter {
        return ($0.value.count >= k)
    }.map {
        $0.key
    }
    
    for (index, id) in id_list.enumerated() {
        var count: Int = 0
        
        // 신고자가 신고한 목록과 k회 이상 신고 당한 유저의 교집합의 Count
        if let value: Set<String> = reporterDic[id] {
            let intersection: Set<String> = value.intersection(filtedReported)
            count = intersection.count
        }
        
        result[index] = count
    }
    
    return result
}

