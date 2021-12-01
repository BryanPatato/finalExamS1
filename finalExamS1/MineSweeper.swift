import Foundation; import CoreGraphics
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
        board = generator(board: board).generate()
    }
}
private class generator
{
    var bombHandler = [0, 0.0, 0.0]
    var activeBoard: [[tileType]]
    init(board: [[tileType]])
    {
        activeBoard = board
        // Base case is an 8 by 8 board
        // in the base case, this would make 20 of the 64 tiles bombs
        bombHandler[0] = floor(Double(Double(board.count)/3.17))
        // in the base case, this would make the bomb density .875 ( This handles extra bombs on larger boards, thus the new bomb total is 22 bombs )
        bombHandler[1] = (56/Double(board.count))
        // in the base case, this would randomly assign a bomb tenacity between 1 and 4    ( This handles bomb clumping )
        bombHandler[2] = CGFloat.random(in: 0...floor(CGFloat(board.count/16 - 1))) + 1
        bombHandler[0] /= floor(bombHandler[1])
        // The reason behind this one here is to make smaller boards have less clumping, yet larger ones happen to clump more-- heck, this actually disincetivises active clumping in the base case, making the lowest tendancy value a -2.
        bombHandler[2] -= ceil(bombHandler[1]*2)
    }
    func generate() -> [[tileType]]
    {
        
    }
}
