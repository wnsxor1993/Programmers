import Foundation

func walkingPark(_ park:[String], _ routes:[String]) -> [Int] {
    guard let firstMap: String = park.first else {
        return [0]
    }
    
    let maxX: Int = firstMap.count
    let maxY: Int = park.count
    var puppyXPosition: Int = 0
    var puppyYPosition: Int = 0
    
    var parkMap: [[Character]] = []
    
    for (index, value) in park.enumerated() {
        let components: [Character] = value.map { $0 }
        
        // 강아지의 현재 위치 확인
        if let widthIndex = components.firstIndex(of: "S") {
            puppyXPosition = widthIndex
            puppyYPosition = index
        }
        
        parkMap.append(components)
    }
    
    routes.forEach {
        let components: [String] = $0.components(separatedBy: " ")
        
        guard let route = components.first, let moveCount: Int = Int(components[1]) else { return }
        
        if route == "N" {
            let newYPosition: Int = (puppyYPosition - moveCount)
            
            guard newYPosition >= 0 else { return }
            
            for index in newYPosition...puppyYPosition {
                let map: [Character] = parkMap[index]
                let value: Character = map[puppyXPosition]
                
                // 이동 경로 중 X가 있으면 전체 이동 취소
                if value == "X" {
                    return
                }
            }
            
            puppyYPosition = newYPosition
            
        } else if route == "S" {
            let newYPosition: Int = (puppyYPosition + moveCount)
            
            guard newYPosition < maxY else { return }
            
            for index in puppyYPosition...newYPosition {
                let map: [Character] = parkMap[index]
                let value: Character = map[puppyXPosition]
                
                if value == "X" {
                    return
                }
            }
            
            puppyYPosition = newYPosition
            
        } else if route == "E" {
            let newXPosition: Int = (puppyXPosition + moveCount)
            
            guard newXPosition < maxX else { return }
            
            for index in puppyXPosition...newXPosition {
                let map: [Character] = parkMap[puppyYPosition]
                let value: Character = map[index]
                
                if value == "X" {
                    return
                }
            }
            
            puppyXPosition = newXPosition
            
        } else {
            let newXPosition: Int = (puppyXPosition - moveCount)
            
            guard newXPosition >= 0 else { return }
            
            for index in newXPosition...puppyXPosition {
                let map: [Character] = parkMap[puppyYPosition]
                let value: Character = map[index]
                
                if value == "X" {
                    return
                }
            }
            
            puppyXPosition = newXPosition
        }
    }
    
    return [puppyYPosition, puppyXPosition]
}
