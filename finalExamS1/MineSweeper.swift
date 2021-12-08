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
    case mine
    case empty
    case number
    var value:String{
        switch self {
        case .mine:
            return "mine"
        case .empty:
            return "blank"
        case .number:
            return "x"
        }
    }
}
public class mineSweeper
{
    var state: activeState
    var board: [[tileType]]
    var hidBoard: [[Bool]]
    var adjacent: [[Int]]
    static var x = 0
    static var y = 0
    fileprivate var c: generator
    init()
    {
        state = .unplayed
        c = generator(boardSizeX: 8, BoardSizeY: 8)
        board = [[]]
        hidBoard = [[]]
        adjacent = [[]]
        mineSweeper.x = 0
        mineSweeper.y = 0
    }
    func initReveal(unit: Int)
    {
        state = .active
        board = c.generate(tapLocal: unit)
        hidBoard = [[Bool]](repeating: [Bool](repeating: false, count: mineSweeper.x), count: mineSweeper.y)
        reveal(unit: unit)
    }
    func reveal(unit: Int)
    {
        if hidBoard[unit % mineSweeper.x][unit / mineSweeper.y] == false
        {
            hidBoard[unit % mineSweeper.x][unit / mineSweeper.y] = true
            switch board[unit % mineSweeper.x][unit / mineSweeper.y] as tileType
            {
            case .mine:
                do
                {
                    state = .explosion
                }
            case .number:
                do
                {
                    
                }
            default:
                do
                {
                    if board[(unit % mineSweeper.x) + 1][unit / mineSweeper.y] == .empty
                    {
                        reveal(unit: unit + mineSweeper.x)
                    }
                    if board[(unit % mineSweeper.x) - 1][unit / mineSweeper.y] == .empty
                    {
                        reveal(unit: unit - mineSweeper.x)
                    }
                    if board[unit % mineSweeper.x][(unit / mineSweeper.y) + 1] == .empty
                    {
                        reveal(unit: unit + 1)
                    }
                    if board[unit / 8][(unit % 8) - 1] == .empty
                    {
                        reveal(unit: unit - 1)
                    }
                }
            }
        }
        hidBoard[unit % mineSweeper.x][unit / mineSweeper.y] = true
    }
    func placeFlag(unit: Int)
    {
        hidBoard[unit % mineSweeper.x][unit / mineSweeper.y] = true
    }
    func remFlag(unit: Int)
    {
        hidBoard[unit % mineSweeper.x][unit / mineSweeper.y] = false
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
            
            for _ in 0...Int(bombHandler[2])
            {
                var randPlaceX = CGFloat.random(in: 0...CGFloat(mineSweeper.x))
                var randPlaceY = CGFloat.random(in: 0...CGFloat(mineSweeper.y))
                if  randPlaceX - 1 > 0 && randPlaceY - 1 > 0 && Int(randPlaceX) + 1 < mineSweeper.x && Int(randPlaceY) + 1 < mineSweeper.y && (newBoard[Int(randPlaceX) - 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX) + 1][Int(randPlaceY)] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) - 1] == .mine || newBoard[Int(randPlaceX)][Int(randPlaceY) + 1] == .mine && Int(randPlaceX) != tapLocal + 1 && Int(randPlaceX) != tapLocal - 1 && Int(randPlaceX) != tapLocal && Int(randPlaceY) != tapLocal + mineSweeper.x && Int(randPlaceY) != tapLocal - mineSweeper.x && Int(randPlaceY) != tapLocal)
                {
                    break
                }
                else
                {
                    randPlaceX = CGFloat.random(in: 0...CGFloat(mineSweeper.x))
                    randPlaceY = CGFloat.random(in: 0...CGFloat(mineSweeper.y))
                }
                newBoard[Int(randPlaceX)][Int(randPlaceY)] = .mine
            }
        }
        return newBoard
    }
    func genAdjacent(tileArray: [[Int]], board: [[tileType]]) -> [[Int]]
    {
        var likewiseTileArray = tileArray
        for e in 0...tileArray.count
        {
            for i in 0...[tileArray].count
            {
                if board[e][i] != .mine
                {
                    if e - 1 > 0 || i - 1 > 0 || e + 1 < tileArray.count || i - 1 < [tileArray].count
                    {
                        for qu in 0...2
                        {
                            for uq in 0...2
                            {
                                if board[e - 1 + qu][i - 1 + uq] == .mine
                                {
                                    likewiseTileArray[e][i] += 1
                                }
                            }
                        }
                    }
                    else
                    {
                        if e == 0 && i == 0
                        {
                            if board[e + 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e + 1][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == mineSweeper.x && i == 0
                        {
                            if board[e - 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e - 1][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == 0 && i == mineSweeper.y
                        {
                            if board[e + 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e + 1][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == mineSweeper.x && i == mineSweeper.y
                        {
                            if board[e - 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e - 1][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if board.count - 1 < 0
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e + qu][i - 1 + uq] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if [board].count - 1 < 0
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - 1 + uq][i + qu] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if board.count + 1 > mineSweeper.x
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - qu][i - 1 + uq] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if board.count + 1 > mineSweeper.y
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - 1 + uq][i - qu] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
      return likewiseTileArray
    }
}
