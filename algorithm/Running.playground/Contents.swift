import Foundation

func running(_ players: [String], _ callings: [String]) -> [String] {
    // 선수 이름과 인덱스를 저장하는 해시 테이블
    var playerIndexMap: [String: Int] = [:]
    var newPlayers: [String] = players
    
    // 선수 이름과 인덱스를 해시 테이블에 저장
    for (index, player) in players.enumerated() {
        playerIndexMap[player] = index
    }
    
    // callings 배열을 순회하면서 선수 위치 변경
    for calling in callings {
        guard let callingIndex: Int = playerIndexMap[calling], callingIndex != 0 else { continue }
        
        let aboveIndex: Int = (callingIndex - 1)
        let abovePerson: String = newPlayers[aboveIndex]
        
        newPlayers[aboveIndex] = calling
        newPlayers[callingIndex] = abovePerson
        
        playerIndexMap[calling] = aboveIndex
        playerIndexMap[abovePerson] = callingIndex
    }
    
    return newPlayers
}
