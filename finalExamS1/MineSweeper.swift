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
    var hidBoard: [[Bool]]
    static var x = 0
    static var y = 0
    fileprivate var c: generator
    init()
    {
        state = .unplayed
        c = generator(boardSizeX: 8, BoardSizeY: 8)
        board = [[]]
        mineSweeper.x = 0
        mineSweeper.y = 0
    }
    func initReveal(indexPath: IndexPath)
    {
        state = .active
        board = c.generate(tapLocal: indexPath.row)
        hidBoard = [[Bool]](repeating: [Bool](repeating: false, count: mineSweeper.x), count: mineSweeper.y)
        reveal(indexPath: indexPath)
    }
    func reveal(indexPath: IndexPath)
    {
        if hidBoard[indexPath.row][indexPath.item] == false
        {
            switch board[indexPath.row][indexPath.item] as tileType
            {
            case .mine:
                do
                {
                    state = .explosion
                }
            case .flag:
                do
                {
                    
                }
            case .number:
                do
                {
                    
                }
            default:
                do
                {
                    
                }
            }
        }
        hidBoard[indexPath.row][indexPath.item] = true
    }
}
private class generator
{
    var bombHandler = [0, 0.0, 0]
    init(boardSizeX: Int, BoardSizeY: Int)
    {
        mineSweeper.x = boardSizeX
        mineSweeper.y = BoardSizeY
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
    func generate(tapLocal: Int) -> [[tileType]]
    {
        var newBoard = [[tileType]](repeating: [tileType](repeating: .empty, count: mineSweeper.y), count: mineSweeper.x)
        for _ in 0...Int(bombHandler[0])
        {
            var randPlaceX = CGFloat.random(in: 0...CGFloat(mineSweeper.x))
            var randPlaceY = CGFloat.random(in: 0...CGFloat(mineSweeper.y))
            for _ in 0...Int(bombHandler[2])
            {
                if  newBoard[Int(randPlaceX) - 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX) + 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) - 1] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) + 1] == .mine && Int(randPlaceX) != tapLocal + 1 && Int(randPlaceX) != tapLocal - 1 && Int(randPlaceX) != tapLocal && Int(randPlaceY) != tapLocal + mineSweeper.x && Int(randPlaceY) != tapLocal - mineSweeper.x && Int(randPlaceY) != tapLocal
                {
                    break
                }
                else
                {
                    randPlaceX = CGFloat.random(in: 0...CGFloat(mineSweeper.x))
                    randPlaceY = CGFloat.random(in: 0...CGFloat(mineSweeper.y))
                }
            }
            newBoard[Int(randPlaceX)][Int(randPlaceY)] = .mine
        }
        return newBoard
    }
}
