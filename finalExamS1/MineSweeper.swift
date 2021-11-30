import Foundation
enum activeState
{
    case unplayed
    case active
    case clear
    case explosion
}
enum tileType
{
    case flag
    case mine
    case empty
    case number
}
public class mineSweeper
{
    var state: activeState
    var board: [[tileType]]
    init()
    {
        state = .unplayed
        
    }
}
private class generator
{
    init(board: [[tileType]])
    {
        
    }
}
