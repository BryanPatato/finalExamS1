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
        let c = generator(boardSizeX: 8, BoardSizeY: 8)
        board = c.generate()
    }
    func initReveal()
    {
        state = .active
        
    }
    func reveal()
    {
        
    }
}
private class generator
{
    var bombHandler = [0, 0.0, 0]
    var x: Int
    var y: Int
    init(boardSizeX: Int, BoardSizeY: Int)
    {
        x = boardSizeX
        y = BoardSizeY
        let base = boardSizeX * BoardSizeY
        // Base case is an 8 by 8 board
        // in the base case, this would make 20 of the 64 tiles bombs
        bombHandler[0] = floor(Double(Double(base)/3.17))
        // in the base case, this would make the bomb density 1 ( This handles extra bombs on larger boards, thus the new bomb total is 20 bombs )
        bombHandler[1] = (64/Double(base))
        // in the base case, this would randomly assign a bomb tenacity between 1 and 3    ( This handles bomb clumping )
        bombHandler[2] = CGFloat.random(in: 0...floor(CGFloat(base/16)) - 1)
        bombHandler[0] /= floor(bombHandler[1])
        // The reason behind this one here is to make smaller boards have less clumping, yet larger ones happen to clump more-- heck, this actually disincetivises active clumping in the base case, making the maximum tendancy value a 1.
        bombHandler[2] -= ceil(bombHandler[1]*2)
    }
    func generate() -> [[tileType]]
    {
        var newBoard = [[tileType]](repeating: [tileType](repeating: .empty, count: y), count: x)
        for _ in 0...Int(bombHandler[0])
        {
            var randPlaceX = CGFloat.random(in: 0...CGFloat(x))
            var randPlaceY = CGFloat.random(in: 0...CGFloat(y))
            for _ in 0...Int(bombHandler[2])
            {
                if  newBoard[Int(randPlaceX) - 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX) + 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) - 1] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) + 1] == .mine
                {
                    break
                }
                else
                {
                    randPlaceX = CGFloat.random(in: 0...CGFloat(x))
                    randPlaceY = CGFloat.random(in: 0...CGFloat(y))
                }
            }
            newBoard[Int(randPlaceX)][Int(randPlaceY)] = .mine
        }
        return newBoard
    }
}
